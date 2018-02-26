Characters

create
curl -d "character[char_id]=999999&character[name]=deadpool&character[image]=deadpool.jpg" -X POST http://localhost:3000/api/v1/characters

index
curl http://localhost:3000/api/v1/characters
show
curl http://localhost:3000/api/v1/characters/100

update
curl -d "character[char_id]=999999&character[name]=deadpool&character[image]=deadpool.jpg" -X PATCH http://localhost:3000/api/v1/characters/106

destroy
curl -X DELETE http://localhost:3000/api/v1/characters/106


Comics

create
curl -d "comic[title]=999999&comic[cover_number]=comic---1&comic[image]=deadpool.jpg" -X POST http://localhost:3000/api/v1/comics

index
curl http://localhost:3000/api/v1/comics
show
curl http://localhost:3000/api/v1/comics/100

update
curl -d "comic[cover_numver]=999999&comic[title]=deadpool&comic[image]=deadpool.jpg" -X PATCH http://localhost:3000/api/v1/comics/848

destroy
curl -X DELETE http://localhost:3000/api/v1/comics/848
