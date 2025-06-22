# db/seeds.rb

# Categorias para o jogo
categories = [
  { name: 'Filmes de Ação' },
  { name: 'Filmes de Animação' },
  { name: 'Filmes de Terror' },
  { name: 'Filmes de Comédia' },
  { name: 'Séries' },
  { name: 'Música' },
  { name: 'Esportes' },
  { name: 'História' },
  { name: 'Ciência' },
  { name: 'Tecnologia' },
  { name: 'Literatura' },
  { name: 'Games' },
  { name: 'Celebridades' },
  { name: 'Folclore' },
  { name: 'Culinária' },
  { name: 'Geografia' },
  { name: 'Arte' },
  { name: 'Animais' },
  { name: 'Saúde' },
  { name: 'Circo' },
  { name: 'Viagens' },
  { name: 'Festas' },
  { name: 'Religião' },
  { name: 'Política' },
  { name: 'Economia' },
  { name: 'Moda' },
  { name: 'Beleza' },
  { name: 'Arquitetura' },
  { name: 'Humoristas' },
  { name: 'Desenhos Animados' },
  { name: 'Super-heróis' },
  { name: 'Brinquedos' },
  { name: 'Instrumentos Musicais' },
  { name: 'Estilos Musicais' },
  { name: 'Futebol' },
  { name: 'Comida' }
]

categories.each do |cat_attrs|
  Category.find_or_create_by!(cat_attrs)
end

words = {
  'Filmes de Ação' => [
    'Gladiador', 'Vingadores', 'Matrix', 'Pantera Negra', 'Star Wars', 'Rocky',
    'Missão Impossível', 'Duro de Matar', 'John Wick', 'Velocidade Máxima', 'Rambo', 'Mad Max',
    'O Protetor', 'Os Mercenários', 'Tropa de Elite', 'O Resgate do Soldado Ryan'
  ],
  'Filmes de Animação' => [
    'Toy Story', 'Shrek', 'Procurando Nemo', 'O Rei Leão', 'Frozen', 'Divertida Mente',
    'Os Incríveis', 'Moana', 'Up', 'Madagascar', 'Kung Fu Panda', 'Meu Malvado Favorito',
    'A Era do Gelo', 'Ratatouille', 'Zootopia', 'Wall-E'
  ],
  'Filmes de Terror' => [
    'O Exorcista', 'Invocação do Mal', 'It', 'Pânico', 'Atividade Paranormal', 'Halloween',
    'A Bruxa', 'Hereditário', 'O Iluminado', 'Corra!', 'Annabelle', 'O Chamado',
    'Jogos Mortais', 'A Morte do Demônio', 'A Freira', 'O Grito'
  ],
  'Filmes de Comédia' => [
    'Se Beber, Não Case', 'As Branquelas', 'O Máskara', 'Todo Mundo em Pânico', 'Debi & Lóide', 'Esqueceram de Mim',
    'Gente Grande', 'Click', 'Ace Ventura', 'Superbad', 'Curtindo a Vida Adoidado', 'American Pie',
    'Os Caça-Fantasmas', 'Apertem os Cintos', 'Zohan', 'O Virgem de 40 Anos'
  ],
  'Séries' => [
    'Friends', 'Breaking Bad', 'Stranger Things', 'Dark', 'The Office', 'Game of Thrones', 'Lost', 'Narcos',
    'La Casa de Papel', 'The Crown', 'House', 'Vikings', 'The Witcher', 'Grey’s Anatomy', 'Black Mirror', 'Sherlock'
  ],
  'Música' => [
    'Beatles', 'Queen', 'Beyoncé', 'Anitta', 'Rock', 'Jazz', 'Samba', 'MPB',
    'Chico Buarque', 'Elvis', 'Madonna', 'Rap', 'Funk', 'Forró', 'Axé', 'Reggae'
  ],
  'Esportes' => [
    'Futebol', 'Olimpíadas', 'Neymar', 'Basquete', 'Maratona', 'Vôlei', 'Tênis', 'Fórmula 1',
    'Surf', 'Skate', 'Handebol', 'Atletismo', 'Ginástica', 'Boxe', 'Xadrez', 'Golfe'
  ],
  'História' => [
    'Egito', 'Roma', 'Independência', 'Revolução', 'Império', 'Grécia', 'Descobrimento', 'Idade Média',
    'Guerra Fria', 'Nazismo', 'Ditadura', 'Colonização', 'Renascimento', 'Iluminismo', 'Inquisição', 'Cruzadas'
  ],
  'Ciência' => [
    'Newton', 'Einstein', 'Gravidade', 'DNA', 'Célula', 'Evolução', 'Big Bang', 'Átomo',
    'Vacina', 'Bactéria', 'Fóton', 'Química', 'Física', 'Matemática', 'Planeta', 'Genética'
  ],
  'Tecnologia' => [
    'Internet', 'Robô', 'Smartphone', 'IA', 'Computador', 'Bluetooth', 'Wi-Fi', 'Satélite',
    'Dron', 'Impressora 3D', 'Blockchain', 'App', 'Cloud', 'Código', 'Rede Social', 'Sensor'
  ],
  'Literatura' => [
    'Shakespeare', 'Dom Quixote', 'Harry Potter', 'Machado', 'Poesia', 'Romance', 'Conto', 'Crônica',
    'Clarice Lispector', 'Saramago', 'Homero', 'Camões', 'Monteiro Lobato', 'Fábula', 'Drama', 'Soneto'
  ],
  'Games' => [
    'Mario', 'Zelda', 'Minecraft', 'Fortnite', 'Pokémon', 'FIFA', 'The Sims', 'Pac-Man',
    'Sonic', 'Counter-Strike', 'League of Legends', 'GTA', 'Tetris', 'Among Us', 'God of War', 'Overwatch'
  ],
  'Celebridades' => [
    'Rihanna', 'Elon Musk', 'Pelé', 'Xuxa', 'Madonna', 'Angelina Jolie', 'Brad Pitt', 'Beyoncé',
    'Neymar', 'Gisele Bündchen', 'Silvio Santos', 'Anitta', 'Faustão', 'Ivete Sangalo', 'Tom Cruise', 'Lady Gaga'
  ],
  'Folclore' => [
    'Saci', 'Curupira', 'Iara', 'Boitatá', 'Lobisomem', 'Mula sem Cabeça', 'Boto', 'Cuca',
    'Negrinho do Pastoreio', 'Caipora', 'Mapinguari', 'Corpo Seco', 'Mãe d\'Água', 'Cabra Cabriola', 'Pisadeira', 'Quibungo'
  ],
  'Culinária' => [
    'Feijoada', 'Moqueca', 'Churrasco', 'Brigadeiro', 'Acarajé', 'Pão de Queijo', 'Tapioca', 'Coxinha',
    'Pastel', 'Vatapá', 'Farofa', 'Baião de Dois', 'Empada', 'Canjica', 'Quindim', 'Escondidinho'
  ],
  'Geografia' => [
    'Brasil', 'Amazonas', 'Everest', 'Deserto', 'Oceano', 'Cordilheira', 'Planície', 'Vulcão',
    'Península', 'Ilha', 'Catarata', 'Polo Norte', 'Equador', 'Latitude', 'Longitude', 'Continente'
  ],
  'Arte' => [
    'Mona Lisa', 'Van Gogh', 'Picasso', 'Davi', 'Michelangelo', 'Salvador Dalí', 'Frida Kahlo', 'Tarsila do Amaral',
    'Graffiti', 'Escultura', 'Pintura', 'Renoir', 'Rembrandt', 'Portinari', 'Cubismo', 'Surrealismo'
  ],
  'Animais' => [
    'Leão', 'Elefante', 'Girafa', 'Tigre', 'Cachorro', 'Gato', 'Baleia', 'Golfinho',
    'Águia', 'Jacaré', 'Cobra', 'Macaco', 'Urso', 'Panda', 'Cavalo', 'Tartaruga'
  ],
  'Saúde' => [
    'Vacina', 'Médico', 'Hospital', 'Remédio', 'Cirurgia', 'Enfermagem', 'Dentista', 'Gripe',
    'Febre', 'Diabetes', 'Pressão', 'Coração', 'Pulmão', 'Sangue', 'Raio-X', 'Exame'
  ],
  'Circo' => [
    'Palhaço', 'Mágico', 'Malabarista', 'Trapézio', 'Equilibrista', 'Domador', 'Leão', 'Acrobata',
    'Globo da Morte', 'Bailarina', 'Ilusionista', 'Foca', 'Elefante', 'Roda Gigante', 'Picadeiro', 'Tenda'
  ],
  'Viagens' => [
    'Avião', 'Hotel', 'Passaporte', 'Mala', 'Cruzeiro', 'Excursão', 'Guia', 'Turismo',
    'Mapa', 'Roteiro', 'Resort', 'Praia', 'Montanha', 'Cidade', 'Passeio', 'Bagagem'
  ],
  'Festas' => [
    'Aniversário', 'Casamento', 'Natal', 'Carnaval', 'Festa Junina', 'Réveillon', 'Chá de Bebê', 'Formatura',
    'Bodas', 'Halloween', 'Páscoa', 'Baile', 'Balada', 'Despedida', 'Noivado', 'Batizado'
  ],
  'Religião' => [
    'Bíblia', 'Igreja', 'Padre', 'Pastor', 'Oração', 'Deus', 'Alá', 'Buda',
    'Torá', 'Cruz', 'Terço', 'Evangelho', 'Santo', 'Anjo', 'Peregrinação', 'Batismo'
  ],
  'Política' => [
    'Presidente', 'Congresso', 'Senado', 'Deputado', 'Voto', 'Eleição', 'Partido', 'Democracia',
    'Ditadura', 'Ministro', 'Prefeito', 'Governador', 'Impeachment', 'Campanha', 'Urna', 'Plenário'
  ],
  'Economia' => [
    'Dinheiro', 'Banco', 'Inflação', 'PIB', 'Bolsa', 'Juros', 'Déficit', 'Lucro',
    'Imposto', 'Salário', 'Mercado', 'Ações', 'Investimento', 'Crédito', 'Débito', 'Orçamento'
  ],
  'Moda' => [
    'Vestido', 'Sapato', 'Camisa', 'Calça', 'Estilista', 'Passarela', 'Desfile', 'Tendência',
    'Acessório', 'Bolsa', 'Chapéu', 'Óculos', 'Joia', 'Cinto', 'Roupa', 'Costura'
  ],
  'Beleza' => [
    'Maquiagem', 'Cabelo', 'Perfume', 'Esmalte', 'Penteado', 'Creme', 'Barbeiro', 'Salão',
    'Unha', 'Sobrancelha', 'Pele', 'Hidratação', 'Corte', 'Escova', 'Máscara', 'Bronzeador'
  ],
  'Arquitetura' => [
    'Prédio', 'Casa', 'Ponte', 'Catedral', 'Arranha-céu', 'Castelo', 'Templo', 'Museu',
    'Teatro', 'Estádio', 'Igreja', 'Palácio', 'Obelisco', 'Monumento', 'Praça', 'Jardim'
  ],
  'Humoristas' => [
    'Chaplin', 'Mussum', 'Didi', 'Renato Aragão', 'Whindersson', 'Tiririca', 'Tom Cavalcante', 'Leandro Hassum',
    'Paulo Gustavo', 'Fábio Porchat', 'Danilo Gentili', 'Marcelo Adnet', 'Tatá Werneck', 'Rafinha Bastos', 'Gregório Duvivier', 'Chico Anysio'
  ],
  'Desenhos Animados' => [
    'Pica-Pau', 'Tom e Jerry', 'Scooby-Doo', 'Os Simpsons', 'Bob Esponja', 'Caverna do Dragão', 'Dragon Ball', 'Naruto',
    'Pokémon', 'Turma da Mônica', 'Peppa Pig', 'Ben 10', 'Hora de Aventura', 'Steven Universo', 'Os Flintstones', 'Os Jetsons'
  ],
  'Super-heróis' => [
    'Superman', 'Batman', 'Homem-Aranha', 'Mulher-Maravilha', 'Capitão América', 'Hulk', 'Thor', 'Homem de Ferro',
    'Pantera Negra', 'Flash', 'Aquaman', 'Wolverine', 'Deadpool', 'Doutor Estranho', 'Homem-Formiga', 'Feiticeira Escarlate'
  ],
  'Brinquedos' => [
    'Boneca', 'Carrinho', 'Lego', 'Quebra-cabeça', 'Pião', 'Bola', 'Yo-yo', 'Bambolê',
    'Playmobil', 'Jogo da Vida', 'Banco Imobiliário', 'Urso de Pelúcia', 'Patinete', 'Skate', 'Bicicleta', 'Autorama'
  ],
  'Instrumentos Musicais' => [
    'Violão', 'Piano', 'Bateria', 'Guitarra', 'Flauta', 'Saxofone', 'Trompete', 'Violino',
    'Teclado', 'Cavaquinho', 'Acordeão', 'Tamborim', 'Pandeiro', 'Harpa', 'Clarinete', 'Oboé'
  ],
  'Estilos Musicais' => [
    'Rock', 'Pop', 'Samba', 'Funk', 'Forró', 'Axé', 'Jazz', 'Blues',
    'Reggae', 'Rap', 'MPB', 'Pagode', 'Sertanejo', 'Bossa Nova', 'Eletrônica', 'Clássica'
  ],
  'Futebol' => [
    'Bola', 'Goleiro', 'Zagueiro', 'Atacante', 'Meio-campo', 'Técnico', 'Estádio', 'Torcida',
    'Camisa', 'Chuteira', 'Cartão', 'Juiz', 'Escanteio', 'Pênalti', 'Copa', 'Campeonato'
  ],
  'Comida' => [
    'Pizza', 'Hambúrguer', 'Sushi', 'Salada', 'Feijão', 'Arroz', 'Macarrão', 'Churrasco',
    'Sorvete', 'Bolo', 'Pão', 'Fruta', 'Legume', 'Peixe', 'Carne', 'Bebida'
  ]
}

words.each do |category_name, word_list|
  category = Category.find_by(name: category_name)
  word_list.each do |word|
    Word.find_or_create_by!(text: word, category: category)
  end
end
