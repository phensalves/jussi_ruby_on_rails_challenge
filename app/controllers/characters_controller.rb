class CharactersController < ApplicationController
  def index
    @characters = Character.all
  end

  def search
    @characters = Character.all
    @query = params[:query]
    @results = Character.where('name LIKE ?', @query)
  end

  def show
    @character = Character.find params[:id]
  end
end
