json.array! @characters do |character|
  json.partial! 'character_elastic_full', character: character
end