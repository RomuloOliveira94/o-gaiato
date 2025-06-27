class ApplicationController < ActionController::Base
  before_action :set_current_attributes

  helper_method :game_owner?

  private

  def current_player
    Player.find_by(id: session[:player_id]) if session[:player_id]
  end

  def set_current_attributes
    Current.player = current_player

    Current.game = Current.player.game if current_player.present?
    Current.game_token = session[:game_token] if session[:game_token]
  end

  def game_owner?
    Current.player&.id == Current.game&.owner&.id
  end
end
