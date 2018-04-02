json.comic_books @comic_books do |comic_book|
	json.partial! 'comic_book', comic_book: comic_book
end