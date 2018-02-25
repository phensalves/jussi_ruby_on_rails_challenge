class Character < ApplicationRecord
  has_many :character_comics, dependent: :destroy
  has_many :comics, through: :character_comics
end
