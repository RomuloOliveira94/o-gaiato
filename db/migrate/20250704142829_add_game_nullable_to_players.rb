class AddGameNullableToPlayers < ActiveRecord::Migration[8.0]
  def change
    change_column_null :players, :game_id, true
  rescue ActiveRecord::StatementInvalid => e
    Rails.logger.error "Erro ao adicionar índice em players: #{e.message}"
    raise e
  end
end
