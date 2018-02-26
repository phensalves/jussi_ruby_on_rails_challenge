class Comic < ApplicationRecord
  include Elasticsearch::Model

  has_many :character_comics, dependent: :destroy
  has_many :characters, through: :character_comics
end
