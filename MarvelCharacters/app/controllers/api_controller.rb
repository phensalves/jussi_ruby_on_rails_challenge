class ApiController < ApplicationController
    def characters
        @characters = Character.all

        render json: @characters
    end

    def character
        @character = Character.find(params[:id])
        @occurences = Occurence.where(:character_id => @character.id)
        @character_comics = []
        for occurence in @occurences do
            comic = Comic.find_by(id: occurence.comic_id)
            @character_comics.push(comic)
        end

        render json: {:character => @character, :comics => @character_comics}
    end

    def comics
        @comics = Comic.all

        render json: @comics
    end

    def comic
        @comic = Comic.find(params[:id])

        render json: @comic
    end

    def search
        if params[:term].nil?
            @characters = []
            @comics = []
        else
            @characters = Character.search params[:term], :size => 100
            @comics = Comic.search params[:term], :size => 100
        end

        # Will fail if Elasticsearch service is not running on port 9200
        begin
            @characters.size
            render json: {:characters => @characters, :comics => @comics, :terms => params[:term]}
        rescue
            redirect_to search_error_path
        end
    end
end