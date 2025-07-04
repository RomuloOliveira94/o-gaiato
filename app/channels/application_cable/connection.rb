module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_player

    def connect
      self.current_player = find_verified_player
    end

    private

    def find_verified_player
      player = Player.find_by(session_id: cookies.encrypted[:session_id].to_s)
      player || reject_unauthorized_connection
    end
  end
end
