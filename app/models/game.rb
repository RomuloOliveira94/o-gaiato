class Game < ApplicationRecord
  has_many :players, dependent: :destroy
  belongs_to :category, optional: true
  belongs_to :word, optional: true
  belongs_to :game_owner, class_name: "Player"
  belongs_to :spy_player, class_name: "Player", optional: true

  enum :status, { waiting: 0, in_progress: 1, finished: 2 }
  enum :result, { no_result: 0, players_win: 1, spy_wins: 2 }
end
