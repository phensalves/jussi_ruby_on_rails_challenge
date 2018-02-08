class SearchController < ApplicationController
    def search
        if params[:term].nil?
            @characters = []
            @comics = []
        else
            @characters = Character.search params[:term], :size => 100
            @comics = Comic.search params[:term], :size => 100
            @query = params[:term]
        end

        # Will fail if Elasticsearch service is not running on port 9200
        begin
            @characters.size
        rescue
            redirect_to search_error_path
        end
    end

    def error
    end
end