json.id		      character.id
json.id_marvel	  character.id_marvel
json.name		  character.name
json.image		  character.image
json.updated_at	  character.updated_at

json.comic_books character.comic_books do |comic_book|
	json.partial! '/api/v1/characters/comic_book', comic_book: comic_book
end
