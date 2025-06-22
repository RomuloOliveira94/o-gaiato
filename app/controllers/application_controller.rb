class ApplicationController < ActionController::Base
  before_action :set_current_attributes

  private

  def current_player
    Player.find_by(id: session[:player_id]) if session[:player_id]
  end

  def set_current_attributes
    Current.player = current_player
    Current.game = @game if defined?(@game) && @game.present?
    Current.session_data = session.to_hash
  end
end
