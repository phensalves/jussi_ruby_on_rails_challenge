class MarvelApiConsume
	def start
		characters
	end

	private

	def characters
		ts = Time.now.to_i.to_s
		hash_digest = md5_generator(ts)
		response = Net::HTTP.get(URI.parse("http://gateway.marvel.com/v1/public/characters?limit=100&ts=#{ts}&apikey=#{ENV["MARVEL_PUBLIC_KEY"]}&hash=#{hash_digest}"))

		data = JSON.parse(response)

		data["data"]["results"].each do |item|
			character = Character.new(marvel_id: item["id"], name: item["name"], image: item["thumbnail"]["path"]+"/portrait_xlarge.jpg", modified: item["modified"])
			character.save!

			comics(item["id"])
		end
	end

	def comics(marvel_id)
		ts = Time.now.to_i.to_s
		hash_digest = md5_generator(ts)

		character = Character.find(marvel_id)

		response = Net::HTTP.get(URI.parse("https://gateway.marvel.com/v1/public/characters/#{marvel_id}/comics?ts=#{ts}&apikey=#{ENV["MARVEL_PUBLIC_KEY"]}&hash=#{hash_digest}"))

		data = JSON.parse(response)

		data["data"]["results"].each do |item|
			begin
				comic = Comic.find(item["id"])
			rescue ActiveRecord::RecordNotFound
				comic = Comic.new(id: item["id"], title: item["title"], cover: item["digitalId"], image: item["thumbnail"]["path"]+"/portrait_xlarge.jpg")
				comic.save!
			end
			character.comics << comic
		end
	end

	def md5_generator(ts)
		md5 = Digest::MD5.new
		md5 << ts << ENV["MARVEL_PRIVATE_KEY"] << ENV["MARVEL_PUBLIC_KEY"]
	end
end
