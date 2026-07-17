# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this app is

"O Gaiato" is a Portuguese-language, session-based party game (a Spyfall/"undercover" clone): players join a game with a code, everyone but one secret "spy" (`o Gaiato`) sees a secret word, players give clues out loud, then vote out who they think the spy is. There are no user accounts — identity is a session-scoped `Player` row.

## Commands

```bash
bin/setup              # bundle install + db:prepare + clear logs/tmp (add --skip-server to not boot bin/dev)
bin/dev                 # foreman: runs `bin/rails server -p 3000` + `bin/rails tailwindcss:watch` (Procfile.dev)
bin/rails db:prepare    # create/migrate/seed as needed
bin/rails db:seed       # loads db/seeds.rb (Category/Word data, all Portuguese)
bin/rails db:migrate

bin/rubocop -f github    # lint, rubocop-rails-omakase style (see .rubocop.yml)
bin/brakeman --no-pager  # static security scan
bin/importmap audit       # audit pinned JS packages for CVEs
```

These three lint/scan commands are exactly what `.github/workflows/ci.yml` runs on every PR (jobs: `scan_ruby`, `scan_js`, `lint`). **There is no test job in CI and no `test/` or `spec/` directory in the repo** — `config/application.rb` even has `# require "rails/test_unit/railtie"` commented out. Don't assume `bin/rails test` or `bundle exec rspec` works out of the box; if asked to add tests, you'll need to wire up a test framework first (minitest railtie or add rspec-rails) before a "run a single test" command exists.

No `package.json` — all JS is vendored through `importmap-rails` (`config/importmap.rb`); there is no `npm`/`yarn`/`esbuild` step. Do not run asset builds manually; `bin/dev` (which shells out to `foreman`) drives both the Rails server and the Tailwind watcher.

Deployment is via Kamal (`config/deploy.yml`, `.kamal/`) to a single Docker image; `bin/kamal console`/`shell` aliases are defined there. `bin/jobs` runs the Solid Queue supervisor standalone (in production it's normally embedded in Puma via `SOLID_QUEUE_IN_PUMA: true`, see `config/deploy.yml`).

## Architecture

**Stack**: Rails ~8.0.2, SQLite (via `solid_queue`/`solid_cache`/`solid_cable` — no Redis, no Postgres), Propshaft + importmap + Tailwind v4 (`tailwindcss-rails`), Turbo + Stimulus, Hotwire Native bridge. Ruby 3.3.0.

**No authentication system.** There's no Devise/Sorcery/accounts. A `Player` is identified purely by an encrypted `session_id` cookie (`ApplicationController#current_player` does `Player.find_by(session_id: session.id.to_s)`). `Current` (`ActiveSupport::CurrentAttributes`) holds `player`/`game`/`game_token` for the request and is populated in `ApplicationController#set_current_attributes` — expect `Current.player` / `Current.game` to be used freely in views instead of controller ivars for anything cross-cutting (e.g. `game_owner?`, `players/_player.html.erb`).

**Domain model** (`app/models`): `Game has_many :players`; a `Game` `belongs_to :category`, `:word`, `:owner` (a `Player`), `:spy_player` (a `Player`) — all `optional: true` because they're nil until the game starts. `Player belongs_to :game` and `:voted_for_player` (self-referential). `Category has_many :words`. Game lifecycle is two enums: `status` (`waiting → in_progress → finished`) and `result` (`no_result / players_win / spy_wins`), both driven from `Game#assign_roles_and_words` (picks random category/word/spy) and `Game#check_game_end_conditions` (tallies votes once everyone has voted — a tie or a wrong majority both count as `spy_wins`). `Player#reset` clears `is_spy`/`has_voted`/`voted_for_player` and is called whenever a player leaves/rejoins/gets kicked.

**Everything is one controller.** `GamesController` (`app/controllers/games_controller.rb`) owns the whole flow: `create`/`join`/`show`/`start`/`vote`/`leave`/`destroy`/`kick_player`, keyed by `game_code` (a `param: :game_code` resource, not `:id` — see `config/routes.rb`). There's no service-object layer yet; game-state logic that isn't pure request orchestration already lives on the `Game`/`Player` models (`assign_roles_and_words`, `check_game_end_conditions`, `reset`) rather than the controller — keep following that split rather than growing controller actions.

**Real-time updates use Turbo 8 broadcast refreshes, not hand-rolled stream actions.** `Game` and `Player` broadcast via `after_update_commit -> { broadcast_action_to ..., action: :refresh }`, paired with `<%= turbo_stream_from @game %>` in `games/show.html.erb`. This is Turbo's built-in page-refresh/morph broadcasting — there's no custom `Turbo.StreamActions` JS. `app/views/games/_game.html.erb` is the state-machine view: it renders `_lobby`, `_in_game`, or `_results` based on `game.status`.

**Forced navigation (kick / cancel game) goes over a separate ActionCable channel**, `UserRedirectChannel` (`app/channels/user_redirect_channel.rb`), which streams to a specific `Player` (`stream_for current_player`) and pushes `{ leave: leave_game_path }` so a kicked/booted client's browser is told to navigate away — this is orthogonal to the Turbo broadcast-refresh mechanism above and shouldn't be conflated with it.

**Hotwire Native integration**: `app/javascript/controllers/bridge/button_controller.js` extends `BridgeComponent` from `@hotwired/hotwire-native-bridge` (pinned in `config/importmap.rb`) to render native-looking buttons inside the iOS/Android Hotwire Native shell (`data: { controller: "bridge--button" }` on links in `home/index.html.erb` and `games/_lobby.html.erb`). The layout (`app/views/layouts/application.html.erb`) checks `hotwire_native_app?` (a Rails/Turbo helper that detects the Turbo Native user agent) to hide the web-only fullscreen toggle when running inside the native shell. The app is also a PWA (`app/views/pwa/manifest.json.erb`, `service-worker.js`, meta tags in the layout) — both delivery paths (PWA and Hotwire Native wrapper) are actively maintained, so check both when changing the layout or navigation behavior.

**Locale**: `config.i18n.default_locale = :"pt-BR"` and `config.time_zone = "Brasilia"` (`config/application.rb`). `config/locales/pt-BR.yml` only translates the `Game` enum values/attributes for ActiveRecord (`I18n.t`/`humanize` use); all other UI copy, flash `notice`/`alert` strings, and validation-adjacent messages are hardcoded Portuguese literals directly in controllers/views (see `GamesController`) rather than routed through locale keys — follow that existing pattern for new flash/copy rather than introducing i18n keys inconsistently.

**Avatars**: `GamesHelper#avatar_url_for` generates a DiceBear (`api.dicebear.com`) fun-emoji SVG URL from an MD5 of the player's name+id — no image uploads/Active Storage involved despite Active Storage being loaded in `config/application.rb`.
