json.id		        comic_book.id
json.cover_number	comic_book.cover_number
json.title		    comic_book.title
json.image		    comic_book.image
json.updated_at		comic_book.updated_at


json.characters comic_book.characters do |character|
	json.partial! '/api/v1/comic_books/character', character: character
end
