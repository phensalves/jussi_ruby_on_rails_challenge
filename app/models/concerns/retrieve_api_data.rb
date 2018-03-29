require 'digest'

class RetrieveApiData
  
  def initialize
  @private_key = 'caefe03fad30ad745d8592e80856727bca7c3613'
  @public_key = '4741ee5fc1815096b0769e4b8ba3e029'
  @limit = 100
  @timestamp = Time.now.to_i.to_s
  
  end
  
  def get_characters
    uri = URI "#{Rails.configuration
               .apis['characters_url']}ts=#{@timestamp}&limit=#{@limit}"\
               "&apikey=#{@public_key}&hash=#{access_key}"
    JSON.parse(Net::HTTP.get(uri))["data"]["results"]
  end
  
  def save_characters
    get_characters.each do |c|
      character = Character.new
      character.name = c["name"]
      character.marvel_id = c["id"]
      character.image = c["thumbnail"]["path"]
      character.modified = c["modified"]
      character.save
    end
  end
  
  def search_comics(character)
    uri = URI "#{Rails.configuration
               .apis['comics_url']}#{character.marvel_id}/comics?"\
               "ts=#{@timestamp}&limit=#{@limit}"\
               "&apikey=#{@public_key}&hash=#{access_key}"

    JSON.parse(Net::HTTP.get(uri))["data"]["results"]
  end

  private
  
  def access_key
    Digest::MD5.hexdigest(@timestamp+@private_key+@public_key)
  end
  
end