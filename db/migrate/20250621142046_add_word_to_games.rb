class AddWordToGames < ActiveRecord::Migration[8.0]
  def change
    add_reference :games, :word, null: true, foreign_key: true
  end
end
