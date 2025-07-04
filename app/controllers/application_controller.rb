class ApplicationController < ActionController::Base
  before_action :set_current_attributes

  helper_method :game_owner?

  private

  def current_player
    Player.find_by(session_id: session.id.to_s)
  end

  def set_current_attributes
    Current.player = current_player
2
    Current.game = Current.player.game if current_player.present?
    cookies.encrypted[:session_id] = Current.player.session_id if Current.player.present?
  end

  def game_owner?
    Current.player&.id == Current.game&.owner&.id
  end
end
