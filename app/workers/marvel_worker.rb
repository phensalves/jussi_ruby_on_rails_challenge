class MarvelWorker
  include Sidekiq::Worker

  attr_accessor :public_key, :private_key, :base_url

  def perform
    @base_url = 'http://gateway.marvel.com'
    @private_key = 'ddcb9ef672c11aa18b584b07866892dacb96f2a4'
    @public_key = '23f2f22c2cb4b14c5772e2ba3cffab1b'

    offset = Character.count
    copy_characters(100, offset)
  end

  private
  def request_hash(timestamp)
    Digest::MD5.hexdigest("#{timestamp}#{private_key}#{public_key}")
  end

  def get_endpoint(url)
    url.gsub("#{base_url}/", "")
  end

  def build_url(endpoint, params = {})
    timestamp = Time.now.to_i
    hash = request_hash(timestamp)
    return "#{base_url}/#{endpoint}?apikey=#{public_key}&hash=#{hash}&ts=#{timestamp}&#{URI.encode_www_form(params)}"
  end

  def copy_characters(limit=1, offset=0)
    response = HTTParty.get build_url("v1/public/characters", {limit: limit, offset: offset})
    if response.code == 200
      data = JSON.parse(response.body)
      if data["code"] == 200 && data["status"] == "Ok" && data["data"]["count"] > 0
        data["data"]["results"].each do |result|
          # saving character
          character = Character.new
          character.marvel_id = result["id"]
          character.name = result["name"]
          character.description = result["description"]
          character.modified = result["modified"]
          character.thumbnail = "#{result["thumbnail"]["path"]}.#{result["thumbnail"]["extension"]}" if !result["thumbnail"].nil?
          if character.save
            copy_comics character
            copy_series character
            copy_stories character
          else
            p ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
            p "CHARACTER BUGS: "
            p character.marvel_id
            p character.name
            p character.errors.full_messages.to_sentence
            p ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
          end
        end
      end
    end
  end

  def copy_comics(character)
    response = HTTParty.get build_url("v1/public/characters/#{character.marvel_id}/comics")
    if response.code == 200
      data = JSON.parse(response.body)
      if data["code"] == 200 && data["status"] == "Ok" && data["data"]["count"] > 0
        data["data"]["results"].each do |result|
          comic = Comic.new
          comic.marvel_id = result["id"]
          comic.character_id = character.id
          comic.marvel_characters_id = character.marvel_id
          comic.title = result["title"]
          comic.description = result["description"]
          comic.thumbnail = "#{result["thumbnail"]["path"]}.#{result["thumbnail"]["extension"]}" if !result["thumbnail"].nil?
          if !comic.save
            p ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
            p "COMIC BUGS: "
            p comic.marvel_id
            p comic.title
            p comic.errors.full_messages.to_sentence
            p ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
          end
        end
      end
    end
  end

  def copy_series(character)
    response = HTTParty.get build_url("v1/public/characters/#{character.marvel_id}/series")
    if response.code == 200
      data = JSON.parse(response.body)
      if data["code"] == 200 && data["status"] == "Ok" && data["data"]["count"] > 0
        data["data"]["results"].each do |result|
          series = Series.new
          series.marvel_id = result["id"]
          series.character_id = character.id
          series.marvel_characters_id = character.marvel_id
          series.title = result["title"]
          series.description = result["description"]
          series.thumbnail = "#{result["thumbnail"]["path"]}.#{result["thumbnail"]["extension"]}" if !result["thumbnail"].nil?
          if !series.save
            p ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
            p "SERIES BUGS: "
            p series.marvel_id
            p series.title
            p series.errors.full_messages.to_sentence
            p ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
          end
        end
      end
    end
  end

  def copy_stories(character)
    response = HTTParty.get build_url("v1/public/characters/#{character.marvel_id}/stories")
    if response.code == 200
      data = JSON.parse(response.body)
      if data["code"] == 200 && data["status"] == "Ok" && data["data"]["count"] > 0
        data["data"]["results"].each do |result|
          story = Story.new
          story.marvel_id = result["id"]
          story.character_id = character.id
          story.marvel_characters_id = character.marvel_id
          story.title = result["title"]
          story.description = result["description"]
          story.thumbnail = "#{result["thumbnail"]["path"]}.#{result["thumbnail"]["extension"]}" if !result["thumbnail"].nil?
          if !story.save
            p ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
            p "STORY BUGS: "
            p story.marvel_id
            p story.title
            p story.errors.full_messages.to_sentence
            p ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
          end
        end
      end
    end
  end
end
