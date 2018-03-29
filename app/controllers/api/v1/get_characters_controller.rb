module Api
  class GetCharactersController < ApplicationController::API
    def create_character
      character = Character.new(required_params)
      character.save
    end
  end
  
  private
  
  def required_params
    params.require(:character).permit(:marvel_id, :name, :image, :modified)
  end
end