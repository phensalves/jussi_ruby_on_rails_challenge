class MarvelApiConsume
	def start
		characters
	end

	private

	def characters		
		response = Net::HTTP.get(URI.parse("http://gateway.marvel.com/v1/public/characters?limit=100&ts=1517861100&apikey=c513ed6bb8b5f32fd251bd7b2a8d41af&hash=17d76d0693a1c82362358c6c9d75e9b9"))

		data = JSON.parse(response)

		data["data"]["results"].each do |item|
			character = Character.new(marvel_id: item["id"], name: item["name"], image: item["thumbnail"]["path"], modified: item["modified"])
			character.save!

			comics(item["id"])
		end
	end

	def comics(marvel_id)
		character = Character.find(marvel_id)

		response = Net::HTTP.get(URI.parse("https://gateway.marvel.com/v1/public/characters/#{marvel_id}/comics?ts=1517861100&apikey=c513ed6bb8b5f32fd251bd7b2a8d41af&hash=17d76d0693a1c82362358c6c9d75e9b9"))

		data = JSON.parse(response)

		data["data"]["results"].each do |item|
			begin
				comic = Comic.find(item["id"])
			rescue ActiveRecord::RecordNotFound
				comic = Comic.new(id: item["id"], title: item["title"], cover: item["digitalId"], image: item["thumbnail"]["path"])
				comic.save!
			end
			character.comics << comic			
		end
	end
end
