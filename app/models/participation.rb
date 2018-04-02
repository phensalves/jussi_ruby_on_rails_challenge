class Participation < ActiveRecord::Base
	belongs_to :character
	belongs_to :comic_book
end