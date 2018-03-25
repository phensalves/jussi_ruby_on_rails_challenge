class Api::MarvelController < ApplicationController
	def index
		characters = Character.all
		render json: {status: 'SUCCESS', message:'All characters loaded below', data:characters}, status: :ok
	end

	def show
		character_id = params["id"]
		character = Character.find(character_id)
		comics = character.comics
		render json: {status: 'SUCCESS', message:'All comics for this characters loaded below', character: character, comics:comics}, status: :ok
	end
end
