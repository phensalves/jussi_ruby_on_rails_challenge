class ComicsController < ApplicationController
  def index
    data = RetrieveApiData.new
    character = Character.find params[:character_id]
    @comics = data.search_comics(character)
  end
end