module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_player

    def connect
      self.current_player = find_verified_player
    end

    private

    def find_verified_player
      player = Player.find_by(id: cookies.encrypted[:player_id])
      player || reject_unauthorized_connection
    end
  end
end
