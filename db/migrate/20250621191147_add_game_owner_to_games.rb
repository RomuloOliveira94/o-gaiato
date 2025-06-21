class AddGameOwnerToGames < ActiveRecord::Migration[8.0]
  def change
    add_reference :games, :game_owner, null: false, foreign_key: { to_table: :players }
  end
end
