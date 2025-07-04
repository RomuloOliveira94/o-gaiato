class Game < ApplicationRecord
  has_many :players
  belongs_to :category, optional: true
  belongs_to :word, optional: true
  belongs_to :owner, class_name: "Player", optional: true
  belongs_to :spy_player, class_name: "Player", optional: true

  after_update_commit -> { broadcast_action_to self, action: :refresh }
  after_create :update_current_attributes

  enum :status, { waiting: 0, in_progress: 1, finished: 2 }
  enum :result, { no_result: 0, players_win: 1, spy_wins: 2 }

  def assign_roles_and_words
    self.category = Category.order("RANDOM()").first
    self.word = self.category.words.order("RANDOM()").first

    players.update_all(is_spy: false)

    self.spy_player = players.sample
    self.spy_player.update(is_spy: true)

    self.status = "in_progress"
    self.start_time = Time.current
    save
  end

  def check_game_end_conditions
    return unless in_progress?

    if players.all?(&:has_voted)
      vote_counts = players.group(:voted_for_player_id).count
      max_count = vote_counts.values.max
      winners  = vote_counts.select { |_, c| c == max_count }.keys

      if winners.size > 1
        self.result = "spy_wins"
      elsif winners.first == spy_player_id
        self.result = "players_win"
      else
        self.result = "spy_wins"
      end

      self.status = "finished"
      save
    end
  end

  private

  def update_current_attributes
    Current.game = self
  end
end
