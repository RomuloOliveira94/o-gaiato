class Player < ApplicationRecord
  belongs_to :game

  after_create_commit -> { broadcast_append_to game, target: "players-list" }
end
