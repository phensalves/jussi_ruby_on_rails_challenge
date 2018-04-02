class ComicBook < ActiveRecord::Base
	has_many	:participations
	has_many	:character, through: :participations
end