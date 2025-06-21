class AddResultToGames < ActiveRecord::Migration[8.0]
  def change
    add_column :games, :result, :integer, default: 0
  end
end
