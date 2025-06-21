class CreateGames < ActiveRecord::Migration[8.0]
  def change
    create_table :games do |t|
      t.string :game_code
      t.integer :status, default: 0
      t.references :spy_player, null: true, foreign_key: { to_table: :players }
      t.datetime :start_time
      t.datetime :end_time

      t.timestamps
    end
    add_index :games, :game_code, unique: true
  end
end
