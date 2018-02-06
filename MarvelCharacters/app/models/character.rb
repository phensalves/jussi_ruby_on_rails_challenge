require 'elasticsearch/model'

class Character < ApplicationRecord
    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks

    has_many :occurences
    has_many :comics, :through => :occurences

    validates :name, :marvel_id, presence: true
    validates :marvel_id, uniqueness: true
    validates :marvel_id, numericality: { only_integer: true }
    validates_associated :comics
end
