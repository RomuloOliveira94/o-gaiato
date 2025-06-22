class Game < ApplicationRecord
  has_many :players, dependent: :destroy
  belongs_to :category, optional: true
  belongs_to :word, optional: true
  belongs_to :owner, class_name: "Player", optional: true
  belongs_to :spy_player, class_name: "Player", optional: true

  after_update_commit -> { broadcast_action_to self, action: :refresh }

  enum :status, { waiting: 0, in_progress: 1, finished: 2 }
  enum :result, { no_result: 0, players_win: 1, spy_wins: 2 }

  def assign_roles_and_words
    self.category = Category.order("RANDOM()").first
    self.word = self.category.words.order("RANDOM()").first

    # Reset todos os players para não-spy
    players.update_all(is_spy: false)

    # Escolhe e define o spy
    self.spy_player = players.sample
    self.spy_player.update(is_spy: true)

    self.status = "in_progress"
    self.start_time = Time.current
    save
  end

  def check_game_end_conditions
    return unless in_progress?

    # Verifica se todos os jogadores votaram
    if players.all?(&:has_voted)
      # Conta os votos
      vote_counts = players.group(:voted_for_player_id).count
      most_voted_player_id = vote_counts.max_by { |_, count| count }&.first

      if most_voted_player_id && most_voted_player_id == spy_player_id
        # Spy foi descoberto - jogadores vencem
        self.result = "players_win"
      else
        # Spy não foi descoberto - spy vence
        self.result = "spy_wins"
      end

      self.status = "finished"
      save
    end
  end
end
