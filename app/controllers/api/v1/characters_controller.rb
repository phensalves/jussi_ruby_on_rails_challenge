class Api::V1::CharactersController < Api::V1::ApiController
  before_action :set_character, only: [:show, :update, :destroy]

  # GET /api/v1/characters
  def index
    limit = params[:limit]
    offset = params[:offset]

    @characters = Character.limit(limit).offset(offset).all

    render status: 200, json: {
      status: 200,
      total: Character.count,
      count: @characters.count,
      limit: limit,
      offset: offset,
      next_page: next_page(limit, offset),
      prev_page: prev_page(limit, offset),
      data: @characters.as_json
    }
  end

  # GET /api/v1/characters/search/:keywords
  def search
    limit = params[:limit] || 10
    offset = params[:offset] || 0
    keywords = params[:keywords]

    @characters = Character.search(keywords).records

    render status: 200, json: {
      status: 200,
      total: Character.count,
      count: @characters.count,
      data: @characters.as_json
    }
  end

  # GET /api/v1/characters/1
  def show
    render status: 200, json: {
      status: 200,
      data: @character.as_json(include: [:comics, :series, :stories])
    }
  end

  # POST /api/v1/characters
  def create
    @character = Character.new(character_params)
    if @character.save
      render status: 200, json: {
        status: 200,
        data: @character.as_json
      }
    else
      render status: 500, json: {
        status: 500,
        errors: @character.errors
      }
    end
  end

  # PATCH/PUT /api/v1/characters/1
  def update
    if @character.update(character_params)
      render status: 200, json: {
        status: 200,
        data: @character.as_json
      }
    else
      render status: 500, json: {
        status: 500,
        errors: @character.errors
      }
    end
  end

  # DELETE /api/v1/characters/1
  def destroy
    @character.destroy
    render status: 200
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_character
    @character = Character.where(id: params[:id]).first
    if @character.nil?
      render status: 404, json: {
        status: 404,
        message: "Character not found"
      }
    end
  end

  # Only allow a trusted parameter "white list" through.
  def character_params
    params.require(:character).permit(:marvel_id, :name, :description, :modified, :thumbnail)
  end

  # Next page
  def next_page(limit, offset)
    if !limit.nil? && !offset.nil?
      offset = offset.to_i + limit.to_i
      return nil if offset >= Character.count
      return api_v1_characters_path(limit: limit, offset: offset)
    end
  end

  # Previous page
  def prev_page(limit, offset)
    if !limit.nil? && !offset.nil?
      offset = offset.to_i - limit.to_i
      offset = 0 if offset < 0
      return api_v1_characters_path(limit: limit, offset: offset)
    end
  end
end
