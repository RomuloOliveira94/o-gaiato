class UserRedirectChannel < ApplicationCable::Channel
  def subscribed
    stream_for current_player
  end
end
