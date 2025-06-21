class CreatePlayers < ActiveRecord::Migration[8.0]
  def change
    create_table :players do |t|
      t.string :name
      t.references :game, null: false, foreign_key: true
      t.boolean :is_spy
      t.boolean :has_voted
      t.references :voted_for_player, foreign_key: { to_table: :players }

      t.timestamps
    end
  end
end
