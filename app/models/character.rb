class Character < ApplicationRecord
	include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  
	has_and_belongs_to_many :comics

	Character.import force: true
end
