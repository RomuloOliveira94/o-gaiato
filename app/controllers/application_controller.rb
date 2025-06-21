class ApplicationController < ActionController::Base
  helper_method :current_player

  private

  def current_player
    @current_player ||= Player.find_by(id: session[:player_id]) if session[:player_id]
  end

  def reload_current_player
    @current_player = nil
    current_player
  end
end
