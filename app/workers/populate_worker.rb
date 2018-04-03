class PopulateWorker
  include Sidekiq::Worker

  def perform
    url = 'http://gateway.marvel.com/v1/public/characters' 
    characters = MarvelApi.call!(url)
    characters.in_groups_of(40, false) { |heroes| create_character_and_comic_books(heroes) }
  end

  private

  def create_character_and_comic_books(heroes)
    objects = []
    heroes.each{ |hero| objects << {id_marvel: hero.id, name: hero.name, image: hero.thumbnail.path, resources: parse_character_comic_items(hero.comics.items)} }
    Character.create(objects)
  end

  def parse_character_comic_items(comics)
    array = []
    comics.each { |comic| array << {name: comic.name, resource_url: comic.resourceURI} } 
    array
  end
end
