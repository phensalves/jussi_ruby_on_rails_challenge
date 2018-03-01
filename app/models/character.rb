class Character < ApplicationRecord
  has_many :comics, dependent: :destroy
  has_many :series, dependent: :destroy
  has_many :stories, dependent: :destroy

  validates :marvel_id, presence: true, uniqueness: true
  validates :name, presence: true
end
