class MarvelApi
  def initialize(url)
    @url = url + marvel_request_params
  end

  def self.call!(url)
    new(url).marvel_request
  end

  def marvel_request_params
    ts = 100
    api_key = 'd33768908d6ac342bcda2d942d239037'
    private_key = 'f6b4d5be7acd2593c5976ab2780a6d149433d21a'
    hash = Digest::MD5.hexdigest(ts.to_s + private_key + api_key)
    "?limit=100&ts=#{ts}&apikey=#{api_key}&hash=#{hash}"
  end

  def marvel_request
    resp = Net::HTTP.get_response(URI.parse(@url))
    response = JSON.parse(resp.body, object_class: OpenStruct) 
    response.data.results
  end
end