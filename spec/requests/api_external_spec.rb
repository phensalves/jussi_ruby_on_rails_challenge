require 'rails_helper'

feature 'External request' do
  it 'queries Marvels characters' do
    public_key = '4741ee5fc1815096b0769e4b8ba3e029'
    access_key = '6fc6f96808766c45c174a5f473d103f1'
    limit = '100'
    timestamp = '1'

    uri = URI "#{Rails.configuration
               .apis['characters_url']}ts=#{timestamp}&limit=#{limit}"\
               "&apikey=#{public_key}&hash=#{access_key}"

    VCR.use_cassette 'api_response' do
      response = Net::HTTP.get_response(URI(uri))
      expect(response.code).to eq('200')
    end
  end
end
