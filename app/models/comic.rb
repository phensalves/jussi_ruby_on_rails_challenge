class Comic < ApplicationRecord
  belongs_to :character, required: true

  validates :marvel_id, presence: true, uniqueness: true
  validates :title, presence: true
end
