class Api::V1::CharactersController < ApplicationController
  before_action :set_contact, only: [:show, :update, :destroy]

  # GET /api/v1/characters
  def index
    limit = params[:limit] || 10
    offset = params[:offset] || 0

    @characters = Character.limit(limit).offset(offset).all

    return render status: 200, json: {
      total: Character.count,
      count: @characters.count,
      limt: limit,
      offset: offset,
      next_page: next_page(limit, offset),
      prev_page: prev_page(limit, offset),
      data: @characters.as_json
    }
  end

  # GET /api/v1/characters/1
  def show
    render json: @character
  end

  # POST /api/v1/characters
  def create
    @character = Character.new(character_params)
    if @character.save
      render json: @character, status: :created
    else
      render json: @character.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/characters/1
  def update
    if @character.update(character_params)
      render json: @character
    else
      render json: @character.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/characters/1
  def destroy
    @character.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_character
    @character = Character.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def character_params
    params.require(:character).permit(:marvel_id, :name, :description, :modified, :thumbnail)
  end

  # Next page
  def next_page(limit, offset)
  end

  # Previous page
  def prev_page(limit, offset)
  end
end
