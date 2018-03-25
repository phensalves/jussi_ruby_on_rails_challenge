class Comic < ApplicationRecord
	include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  
	has_and_belongs_to_many :characters

	begin
	Comic.import force: true
	rescue => e
		Rails.logger.info(e)
	end
end
