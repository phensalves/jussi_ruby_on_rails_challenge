class Api::V1::CharactersController < ApplicationController
  before_action :set_character, only: [:show, :update, :destroy]

  def index
    characters = Character.all
    render json: characters
  end

  def show
    if @character
      render json: @character
    else
      render json: { message: "Not found" }, status: 404
    end
  end

  def create
    character = Character.new(character_params)
    if character.save
      render json: character, status: 201
    else
      render json: { errors: character.errors }, status: 422
    end
  end

  def update
    if @character.update_attributes(character_params)
      @character.update_attributes(modified: Time.current)
      render json: @character, status: 200
    else
      render json: { errors: @character.errors }, status: 422
    end
  end

  def destroy
    if @character.destroy
      head 204
    end
  end

  private

  def set_character
    begin
      @character = Character.find(params[:id])
    rescue
      nil
    end
  end

  def character_params
    params.require(:character).permit(:char_id, :name, :image)
  end
end
