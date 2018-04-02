namespace :characters do

  desc 'Collect and Populate Characters'
  task collect: :environment do
    url = 'http://gateway.marvel.com/v1/public/characters?ts=1&apikey=d33768908d6ac342bcda2d942d239037&hash=43be5783174524298e753010ae91abad'
    resp = Net::HTTP.get_response(URI.parse(url))
    data = JSON.parse(resp.body) 
    characters = data["data"]["results"]

    characters.each do |hero|
      create_character(hero)
    end
  end

  def create_character(hero)
    Character.create do |c|
      c.id_marvel = hero["id"] 
      c.name = hero["name"]
      c.image = hero["thumbnail"]["path"]
      create_comic_books(hero["comics"]["items"])
      c.comic_books = @comic_book_arr if !@comic_book_arr.empty?
      puts "====> create hero #{c.name}"
    end
  end

  def create_comic_books(comic_books)
    @comic_book_arr = []
    comic_books.each do |comic|
      comic_book = ComicBook.where(title: comic["name"]).first
      if !comic_book.present?
        url = comic["resourceURI"] + "?ts=1&apikey=d33768908d6ac342bcda2d942d239037&hash=43be5783174524298e753010ae91abad"
        resp = Net::HTTP.get_response(URI.parse(url))
        data = JSON.parse(resp.body) 
        comic_book_data = data["data"]["results"].first
        
        comic_book =ComicBook.new
        comic_book.title = comic_book_data["name"] || comic_book_data["title"]
        comic_book.cover_number = comic_book_data["issueNumber"]
        comic_book.image = comic_book_data["thumbnail"]["path"]
        puts "=========> create comic book #{comic_book.title}" if comic_book.save
        comic_book
      end
      @comic_book_arr << comic_book
    end 
  end
end