# O Gaiato

![Badge de Tecnologia](https://img.shields.io/badge/Ruby-CC342D?style=for-the-badge&logo=ruby&logoColor=white)
![Badge de Tecnologia](https://img.shields.io/badge/Ruby%20on%20Rails-CC0000?style=for-the-badge&logo=rubyonrails&logoColor=white)
![Badge de Tecnologia](https://img.shields.io/badge/Tailwind%20CSS-38B2AC?style=for-the-badge&logo=tailwind-css&logoColor=white)
![Badge de Tecnologia](https://img.shields.io/badge/SQLite-07405E?style=for-the-badge&logo=sqlite&logoColor=white)

Um divertido jogo de dedução social para jogar com amigos, desenvolvido com Ruby on Rails e WebSockets para uma experiência em tempo real.

## 📜 Sobre o Jogo

<img width="271" height="213" alt="image" src="https://github.com/user-attachments/assets/5c093fcb-a9b1-4035-bd66-90d6f7c670a2" />

**O Gaiato** é um jogo onde os jogadores precisam usar a criatividade e a perspicácia para descobrir o impostor entre eles. Um jogador é secretamente designado como o "Gaiato" e não sabe qual é a palavra secreta, enquanto todos os outros sabem. O objetivo dos jogadores é descobrir quem é o Gaiato, e o objetivo do Gaiato é se misturar e adivinhar a palavra secreta.

## 🛠️ Tecnologias Utilizadas

O projeto foi construído utilizando as seguintes tecnologias:

* **Backend:** Ruby on Rails
* **Frontend:** Tailwind CSS
* **Comunicação em tempo real:** WebSockets (Action Cable)
* **Banco de Dados:** SQLite
* **Linguagem:** Ruby

## 룰 Regras do Jogo

1.  **Sorteio:** No início de cada rodada, um jogador é secretamente sorteado para ser o **Gaiato** e uma palavra secreta é escolhida a partir de um tema definido.
2.  **A Palavra Secreta:**
    * Todos os jogadores, exceto o Gaiato, sabem qual é a palavra secreta.
    * O Gaiato não sabe a palavra, mas tem acesso ao tema e à lista de palavras possíveis, assim como todos os outros jogadores.
3.  **Dando as Dicas:** Em ordem, cada jogador deve dar uma dica de **uma única palavra** relacionada à palavra secreta.
    * As dicas devem ser boas o suficiente para provar que você sabe a palavra, mas não tão óbvias a ponto de o Gaiato descobrir qual é.
    * O Gaiato também deve dar uma dica, tentando enganar os outros e se passar por um jogador que sabe a palavra.
4.  **A Votação:** Após todos darem suas dicas, uma rodada de discussão é aberta e, em seguida, todos os jogadores votam em quem eles acreditam ser o Gaiato.
5.  **O Fim da Rodada:**
    * Se o jogador mais votado for o Gaiato, os outros jogadores vencem!
    * Se o jogador mais votado não for o Gaiato, o Gaiato vence a rodada.

## 🚀 Como Executar o Projeto (Exemplo)

Para rodar o projeto em seu ambiente local, siga os passos abaixo:

1.  **Clone o repositório:**
    ```bash
    git clone [https://github.com/RomuloOliveira94/o-gaiato.git](https://github.com/RomuloOliveira94/o-gaiato.git)
    cd o-gaiato
    ```

2.  **Instale as dependências:**
    ```bash
    bundle install
    ```

3.  **Configure o banco de dados:**
    ```bash
    rails db:create
    rails db:migrate
    ```

4.  **Inicie o servidor:**
    ```bash
    rails server
    ```

5.  Abra seu navegador e acesse `http://localhost:3000`.

## 🤝 Como Contribuir

Contribuições são bem-vindas! Se você tiver ideias para novas funcionalidades, melhorias ou correções de bugs, sinta-se à vontade para abrir uma *issue* ou enviar um *pull request*.

1.  Faça um *fork* do projeto.
2.  Crie uma nova *branch* (`git checkout -b feature/sua-feature`).
3.  Faça o *commit* das suas alterações (`git commit -m 'Adiciona nova feature'`).
4.  Faça o *push* para a *branch* (`git push origin feature/sua-feature`).
5.  Abra um *Pull Request*.

## 📄 Licença

Este projeto está sob a licença MIT. Veja o arquivo [LICENSE](LICENSE) para mais detalhes. (Você precisará criar este arquivo se quiser adicionar uma licença).
