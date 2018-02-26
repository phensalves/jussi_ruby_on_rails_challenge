require 'rails_helper'

RSpec.describe 'Characters', type: :request do
  let(:character) { Character.create(char_id: '123', name: 'teste', image: '123456', modified: Time.current) }
  let(:char_id) { character.id }

  let(:headers) do
    {
      'Accept' => 'application/vnd.taskmanager.api',
      'Content-Type' => Mime[:json].to_s
    }
  end

  describe 'GET' do

    describe 'characters/:id' do
      before do
        get "/characters/#{char_id}", params: {}, headers: headers
      end

      context 'when the characters exists' do
        it 'returns status code 200' do
          expect(response).to have_http_status(:success)
        end
      end

      context 'when the characters does not exist' do
        let(:char_id) { 10000000 }
        it 'returns status code 404' do
          expect(response).to have_http_status(404)
        end
      end

    end
  end

  describe 'POST /characters' do

    before do
      post '/characters', params: { character: char_params }.to_json, headers: headers
    end

    context 'when the request params are valid' do
      let(:char_params) { { char_id: '123', name: 'teste', image: '123456', modified: Time.current } }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end
  end

  describe 'PUT' do
    before do
      put "/characters/#{char_id}", params: { character: char_params }.to_json, headers: headers
    end

    context 'when the request params are valid' do
      let(:char_params) { { name: 'dois' } }
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end
  end

  describe 'DELETE' do
    before do
      delete "/characters/#{char_id}", params: {}, headers: headers
    end

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end

    it 'removes the character from database' do
      expect( Character.find_by(id: character.id) ).to be_nil
    end
  end

end
