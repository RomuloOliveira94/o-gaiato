<div align="center">

# 🕵️ O Gaiato

### Um jogo de dedução social multiplayer, direto do navegador — sem app, sem cadastro, só o código da sala.

[![Ruby](https://img.shields.io/badge/Ruby-3.3.0-CC342D?logo=ruby&logoColor=white)](.ruby-version)
[![Rails](https://img.shields.io/badge/Rails-8.0-CC0000?logo=rubyonrails&logoColor=white)](Gemfile)
[![PWA](https://img.shields.io/badge/PWA-ready-5A0FC8?logo=pwa&logoColor=white)](app/views/pwa/manifest.json.erb)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

</div>

---

## 🎉 Sobre

<img width="271" height="213" alt="Captura de tela do jogo O Gaiato" src="https://github.com/user-attachments/assets/5c093fcb-a9b1-4035-bd66-90d6f7c670a2" />

**O Gaiato** é a implementação em Ruby on Rails do clássico jogo de dedução social (estilo *Spyfall*/"undercover"), em português. Um tema e uma palavra secreta são sorteados, todo mundo vê a palavra... menos **O Gaiato**, o espião da rodada. Os jogadores dão dicas verbais, discutem, votam — e descobrem se acertaram o disfarçado.

Não tem contas, não tem senha: cada jogador entra numa sala com um código e joga direto pelo celular ou navegador, no mesmo ambiente físico dos amigos.

📖 As regras completas do jogo estão em **[RULES.md](RULES.md)**.

## 🛠️ Tecnologias

| Camada | Tecnologia |
|---|---|
| Backend | [Ruby on Rails 8](https://rubyonrails.org/) |
| Frontend reativo | [Hotwire](https://hotwired.dev/) — Turbo + Stimulus |
| App nativo (iOS/Android) | [Hotwire Native](https://native.hotwired.dev/) |
| Instalável no celular | PWA (manifest + service worker) |
| Banco de dados | SQLite |
| Filas de background | [Solid Queue](https://github.com/rails/solid_queue) |
| Cache | [Solid Cache](https://github.com/rails/solid_cache) |
| WebSockets (Action Cable) | [Solid Cable](https://github.com/rails/solid_cable) |
| Assets JS | Importmap (sem Node/Webpack) |
| CSS | Tailwind CSS v4 |
| Deploy | [Kamal](https://kamal-deploy.org/) |

Sem Redis, sem Postgres, sem `node_modules` — tudo roda com SQLite e importmap, o que mantém o setup local extremamente simples.

## 🚀 Como rodar localmente

### Pré-requisitos

- Ruby **3.3.0** (veja [`.ruby-version`](.ruby-version); recomendado usar [rbenv](https://github.com/rbenv/rbenv) ou [asdf](https://asdf-vm.com/))
- SQLite3

### Setup

```bash
git clone https://github.com/RomuloOliveira94/o-gaiato.git
cd o-gaiato
bin/setup
```

O `bin/setup` já instala as gems, prepara o banco de dados (`db:prepare`, que cria/migra e roda o `db:seed` com as categorias e palavras) e sobe o servidor local. Se quiser só preparar o ambiente sem subir o servidor:

```bash
bin/setup --skip-server
```

### Rodando o servidor

```bash
bin/dev
```

Isso sobe, via [Foreman](https://github.com/ddollar/foreman) (`Procfile.dev`), o servidor Rails (`bin/rails server -p 3000`) e o watcher do Tailwind (`bin/rails tailwindcss:watch`) ao mesmo tempo. Acesse **http://localhost:3000**.

### Banco de dados

```bash
bin/rails db:prepare   # cria/migra o banco se necessário
bin/rails db:seed      # (re)carrega categorias e palavras em português
```

## 🤝 Como contribuir

1. Faça um **fork** do repositório.
2. Crie uma branch a partir da `main`: `git checkout -b minha-feature`.
3. Faça suas alterações seguindo as convenções do projeto (veja `CLAUDE.md` para arquitetura e padrões).
4. Antes de abrir o PR, rode as checagens que também rodam no CI (`.github/workflows/ci.yml`):

   ```bash
   bin/rubocop -f github     # lint (rubocop-rails-omakase)
   bin/brakeman --no-pager   # análise estática de segurança
   bin/importmap audit       # audita dependências JS pinadas
   ```

5. Abra um **Pull Request** descrevendo o que mudou e por quê.

> ⚠️ Este projeto ainda não tem uma suíte de testes configurada — se sua contribuição precisar de testes, converse antes no PR sobre a melhor forma de configurá-los.

## 📄 Licença

Distribuído sob a licença **MIT**. Veja [`LICENSE`](LICENSE) para mais detalhes.
