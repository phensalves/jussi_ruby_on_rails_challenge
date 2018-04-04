namespace :characters do

  desc 'Collect and Populate Charactersß  '
  task collect: :environment do
    url = 'http://gateway.marvel.com/v1/public/characters' + marvel_request_params 
    characters = marvel_request(url)
    characters.each do |hero|
      create_character_and_comic_books(hero)
    end
  end

  def create_character_and_comic_books(hero)
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
    comic_books.each do |comic_book|
      create_comic_book(comic_book)
    end 
  end

  def create_comic_book(hq)
    comic_book = ComicBook.where(title: hq["name"]).first

      if !comic_book.present?
        url = hq["resourceURI"] + marvel_request_params 
        comic_book_data = marvel_request(url).first

        comic_book = ComicBook.new
        comic_book.title = comic_book_data["name"] || comic_book_data["title"]
        comic_book.cover_number = comic_book_data["issueNumber"]
        comic_book.image = comic_book_data["thumbnail"]["path"]
        puts "=========> create comic book #{comic_book.title}" if comic_book.save
        comic_book
      end
      @comic_book_arr << comic_book
  end

  def marvel_request_params
    ts = 100
    api_key = 'd33768908d6ac342bcda2d942d239037'
    private_key = 'f6b4d5be7acd2593c5976ab2780a6d149433d21a'
    hash = Digest::MD5.hexdigest(ts.to_s + private_key + api_key)
    "?limit=100&ts=#{ts}&apikey=#{api_key}&hash=#{hash}"
  end

  def marvel_request(url)
    resp = Net::HTTP.get_response(URI.parse(url))
    data = JSON.parse(resp.body) 
    data["data"]["results"]
  end
end