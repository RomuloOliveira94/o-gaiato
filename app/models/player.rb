class Player < ApplicationRecord
  belongs_to :game
  belongs_to :voted_for_player, class_name: "Player", optional: true

  after_create_commit -> { broadcast_append_to game, target: "players-list" }
  after_update_commit -> { broadcast_replace_to game, target: self }
  after_destroy_commit -> { broadcast_remove_to game, target: self }
end
