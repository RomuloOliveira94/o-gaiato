class Game < ApplicationRecord
  has_many :players, dependent: :destroy
  belongs_to :category, optional: true
  belongs_to :word, optional: true

  enum :status, { waiting: 0, in_progress: 1, finished: 2 }
end
