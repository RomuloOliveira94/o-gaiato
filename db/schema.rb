# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_07_04_142829) do
  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_categories_on_name", unique: true
  end

  create_table "games", force: :cascade do |t|
    t.string "game_code"
    t.integer "status", default: 0
    t.integer "spy_player_id"
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "category_id"
    t.integer "word_id"
    t.integer "owner_id"
    t.integer "result", default: 0
    t.index ["category_id"], name: "index_games_on_category_id"
    t.index ["game_code"], name: "index_games_on_game_code", unique: true
    t.index ["owner_id"], name: "index_games_on_owner_id"
    t.index ["spy_player_id"], name: "index_games_on_spy_player_id"
    t.index ["word_id"], name: "index_games_on_word_id"
  end

  create_table "players", force: :cascade do |t|
    t.string "name"
    t.integer "game_id"
    t.boolean "is_spy"
    t.boolean "has_voted"
    t.integer "voted_for_player_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "session_id"
    t.index ["session_id"], name: "index_players_on_session_id", unique: true
    t.index ["voted_for_player_id"], name: "index_players_on_voted_for_player_id"
  end

  create_table "words", force: :cascade do |t|
    t.string "text"
    t.integer "category_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_words_on_category_id"
  end

  add_foreign_key "games", "categories"
  add_foreign_key "games", "players", column: "owner_id"
  add_foreign_key "games", "players", column: "spy_player_id"
  add_foreign_key "games", "words"
  add_foreign_key "players", "games"
  add_foreign_key "players", "players", column: "voted_for_player_id"
  add_foreign_key "words", "categories"
end
