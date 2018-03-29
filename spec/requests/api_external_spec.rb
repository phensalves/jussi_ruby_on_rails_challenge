require 'rails_helper'
#WebMock.allow_net_connect!
feature 'External request' do
  it 'queries FactoryGirl contributors on GitHub' do
    
    uri = URI('http://gateway.marvel.com/v1/public/characters?ts=1&limit=100&apikey=4741ee5fc1815096b0769e4b8ba3e029&hash=6fc6f96808766c45c174a5f473d103f1')
    VCR.use_cassette 'api_response' do
      response = Net::HTTP.get_response(URI(uri))
 #    json = JSON.parse(response.body)
      expect(response.code).to eq('200')
 #   puts json
    end
  end
end