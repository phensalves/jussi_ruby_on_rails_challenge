class ComicBook < ActiveRecord::Base
	has_many	:participations
	has_many	:characters, through: :participations

  validates :title, uniqueness: true, presence: true
end