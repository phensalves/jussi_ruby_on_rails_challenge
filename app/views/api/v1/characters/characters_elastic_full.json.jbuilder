json.array! @characters do |characters|
  json.partial! 'character_elastic_full', characters: characters
end