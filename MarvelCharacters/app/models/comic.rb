require 'elasticsearch/model'

class Comic < ApplicationRecord
    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks

    has_many :occurences
    has_many :characters, :through => :occurences
    
    validates :title, :marvel_id, presence: true
    validates :marvel_id, uniqueness: true
    validates :marvel_id, numericality: { only_integer: true }
end