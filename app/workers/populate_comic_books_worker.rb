class PopulateComicBooksWorker
  include Sidekiq::Worker

  def perform(id)
    character = Character.find_by_id(id)
    return unless character

    character.resources.each{ |resource| character.comic_books.new(get_comic_book(resource)).save }  
  end

  def get_comic_book(resource={})
    comic_book = MarvelApi.call!(resource["resource_url"]).first
    {title: comic_book&.title || comic_book&.name, cover_number: comic_book.issueNumber, image: comic_book.thumbnail.path}
  end
end