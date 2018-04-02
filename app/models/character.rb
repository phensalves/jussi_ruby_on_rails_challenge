class Character < ActiveRecord::Base
	has_many	:participations
	has_many	:comic_books, through: :participations
end