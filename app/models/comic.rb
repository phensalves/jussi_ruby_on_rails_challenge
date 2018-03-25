class Comic < ApplicationRecord
	include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  
	has_and_belongs_to_many :characters

	Comic.import force: true
end
