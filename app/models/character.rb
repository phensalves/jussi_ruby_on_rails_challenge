class Character < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

	has_many	:participations
	has_many	:comic_books, through: :participations
  validates :id_marvel, presence: true, uniqueness: true

  after_create :create_comic_books

  #MAPPING ELASTIC
  settings index: { number_of_shards: 1, number_of_replicas: 0 } do
    mapping do
      indexes :id, type: 'integer'
      indexes :name, type: 'text'
      indexes :image, type: 'text'
    end
  end
    
  def as_indexed_json(options={})
    {
      id:                self.id,
      name:              self.name,
      image:             self.image,
    }
  end

  private

  def create_comic_books
    PopulateComicBooksWorker.perform_async(self.id)
  end

end