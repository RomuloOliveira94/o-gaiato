class AddOwnerToGames < ActiveRecord::Migration[8.0]
  def change
    add_reference :games, :owner, null: true, foreign_key: { to_table: :players }
  end
end
