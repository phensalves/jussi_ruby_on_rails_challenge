json.array! @characters do |characters|
  json.partial! 'character_elastic', characters: characters
end