json.characters @characters do |character|
	json.partial! 'character', character: character
end