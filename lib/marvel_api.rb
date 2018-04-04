class MarvelApi
  def initialize(url)
    @url = url + marvel_request_params
  end

  def self.call!(url)
    new(url).marvel_request
  end

  def marvel_request_params
    ts = 100
    limit = 100
    api_key = 'd343ee26e8157f2d43f16c00615eb1f4'
    private_key = '79a2e82ab086439ede352fc941bcaf363856a114'
    hash = Digest::MD5.hexdigest(ts.to_s + private_key + api_key)
    "?limit=#{limit}&ts=#{ts}&apikey=#{api_key}&hash=#{hash}"
  end

  def marvel_request
    resp = Net::HTTP.get_response(URI.parse(@url))
    response = JSON.parse(resp.body, object_class: OpenStruct) 
    response.data.results
  end
end