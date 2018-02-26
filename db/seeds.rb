# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


require 'open-uri'

chars = open('https://gateway.marvel.com/v1/public/characters?limit=100&ts=1234&apikey=5aebce493046833c9949eb130e167132&hash=8f4bfbafdf6a0f004a8d4cce0d010c8d')
response = chars.read
response = JSON.parse(response)
response['data']['results'].each do |char_item|
  p char_item['name']
  marvel_char = Character.find_or_create_by(
                            char_id: char_item['id'],
                            name: char_item['name'],
                            image: char_item['thumbnail']['path'] + '/portrait_small.' + char_item['thumbnail']['extension'],
                            modified: char_item['modified'].to_datetime)

  char_comics = open("http://gateway.marvel.com/v1/public/characters/#{marvel_char.char_id}/comics?ts=1234&apikey=5aebce493046833c9949eb130e167132&hash=8f4bfbafdf6a0f004a8d4cce0d010c8d")
  marvel_char_response = char_comics.read
  marvel_char_response = JSON.parse(marvel_char_response)
  marvel_char_response['data']['results'].each do |comic_item|
    p comic_item['title']
    comic = Comic.find_or_create_by(
                    title: comic_item['title'],
                    cover_number: comic_item['issueNumber'],
                    image: comic_item['thumbnail']['path'] + '/portrait_small.' + comic_item['thumbnail']['extension'])

  CharacterComic.create(character: marvel_char, comic: comic)
  end
end
