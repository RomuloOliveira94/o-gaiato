class AddCategoryToGames < ActiveRecord::Migration[8.0]
  def change
    add_reference :games, :category, null: true, foreign_key: true
  end
end
