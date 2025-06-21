class Word < ApplicationRecord
  belongs_to :category

  validates :text, presence: true, uniqueness: { scope: :category_id }
end
