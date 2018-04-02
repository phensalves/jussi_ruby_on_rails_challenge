class Character < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

	has_many	:participations
	has_many	:comic_books, through: :participations
end