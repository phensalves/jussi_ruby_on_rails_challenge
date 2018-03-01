class Character < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  settings index: { number_of_shards: 1 } do
  	mapping dynamic: false do
  		indexes :marvel_id, analyzer: 'english'
  		indexes :name, analyzer: 'english'
  	end
  end

  has_many :comics, dependent: :destroy
  has_many :series, dependent: :destroy
  has_many :stories, dependent: :destroy

  validates :marvel_id, presence: true, uniqueness: true
  validates :name, presence: true
end
Character.import
