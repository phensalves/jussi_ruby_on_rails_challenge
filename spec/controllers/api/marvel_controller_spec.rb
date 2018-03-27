describe Api::MarvelController do
	describe 'GET api/marvel/characters' do
		context 'should return a list with marvel characters' do
			get '/api/marvel/characters'
			expect(response.status).to eql(200)
		end
	end
end
