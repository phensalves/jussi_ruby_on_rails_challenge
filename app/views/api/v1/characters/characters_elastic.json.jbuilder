json.array! @characters do |character|
  json.partial! 'character_elastic', character: character
end