class AddSessionIdToPlayers < ActiveRecord::Migration[8.0]
  def change
    add_column :players, :session_id, :string

    add_index :players, :session_id, unique: true
  end
end
