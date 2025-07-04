class Player < ApplicationRecord
  belongs_to :game, optional: true
  belongs_to :voted_for_player, class_name: "Player", optional: true

  after_create_commit -> { broadcast_action_to game, target: "players-list", action: :refresh }
  after_update_commit -> { broadcast_action_to game, target: self, action: :refresh }

  def reset
    self.voted_for_player = nil
    self.has_voted = false
    self.is_spy = false
  end
end
