class CharactersController < ApplicationController
    
    def index
        @characters = Character.all
    end
    
    def search
        @characters = Character.all
        @query = params[:query]
    end
end