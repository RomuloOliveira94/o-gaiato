# db/seeds.rb

# Categorias para o jogo
categories = [
  { name: 'Filmes' },
  { name: 'Séries' },
  { name: 'Música' },
  { name: 'Esportes' },
  { name: 'História' },
  { name: 'Ciência' },
  { name: 'Tecnologia' },
  { name: 'Literatura' },
  { name: 'Games' },
  { name: 'Celebridades' }
]

categories.each do |cat_attrs|
  Category.find_or_create_by!(cat_attrs)
end

words = {
  'Filmes' => [ 'Titanic', 'Matrix', 'Avatar', 'Interestelar', 'Vingadores' ],
  'Séries' => [ 'Friends', 'Breaking Bad', 'Stranger Things', 'Dark', 'The Office' ],
  'Música' => [ 'Beatles', 'Queen', 'Beyoncé', 'Anitta', 'Rock' ],
  'Esportes' => [ 'Futebol', 'Olimpíadas', 'Neymar', 'Basquete', 'Maratona' ],
  'História' => [ 'Egito', 'Roma', 'Independência', 'Revolução', 'Império' ],
  'Ciência' => [ 'Newton', 'Einstein', 'Gravidade', 'DNA', 'Célula' ],
  'Tecnologia' => [ 'Internet', 'Robô', 'Smartphone', 'IA', 'Computador' ],
  'Literatura' => [ 'Shakespeare', 'Dom Quixote', 'Harry Potter', 'Machado', 'Poesia' ],
  'Games' => [ 'Mario', 'Zelda', 'Minecraft', 'Fortnite', 'Pokémon' ],
  'Celebridades' => [ 'Rihanna', 'Elon Musk', 'Pelé', 'Xuxa', 'Madonna' ]
}

words.each do |category_name, word_list|
  category = Category.find_by(name: category_name)
  word_list.each do |word|
    Word.find_or_create_by!(text: word, category: category)
  end
end
