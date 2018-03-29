require 'rails_helper'

  describe 'Messages API' do
    it 'receive a OK response' do
      get 'http://gateway.marvel.com/v1/public/characters?ts=1&limit=100&apikey=4741ee5fc1815096b0769e4b8ba3e029&hash=6fc6f96808766c45c174a5f473d103f1'
      json = JSON.parse(responde.body)
      
      expect(response).to be_success
    end
  end