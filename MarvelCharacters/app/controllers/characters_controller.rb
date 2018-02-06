class CharactersController < ApplicationController
    def new
    end

    def create
        # Create requested character object
        @character = Character.new(character_params)
 
        begin
            # Fetch character from Marvel API
            response = fetch_character

            if response[:code] == 200
                assign_character_data(response)

                # Save to database if is a new character
                if @character.save
                    fetch_and_save_comics_from_character(response)

                    flash[:notice] = "Added " + @character.name + " to the characters roster."
                    redirect_to @character
                
                # Database already have this character register
                else
                    flash[:notice] = "The roster already had " + @character.name + " in it."
                    redirect_to @character
                end
            
            # Unable to find character
            else
                flash[:alert] = "Failed to find and fetch character data. Is the name correct?"
                redirect_to new_character_path
            end
       
        # Unable to connect to Marvel API
        rescue Exception => e
            puts e.message 
            flash[:alert] = "Failed to connect to Marvel. Bad API keys?"
            redirect_to new_character_path
        end
    end

    def show
        @character = Character.find(params[:id])
        @occurences = Occurence.where(:character_id => @character.id)
        @character_comics = []
        for occurence in @occurences do
            comic = Comic.find_by(id: occurence.comic_id)
            @character_comics.push(comic)
        end
    end

    def index
        @characters = Character.all
    end

    private
        def character_params
            params.require(:character).permit(:name)
        end

        def connect_to_marvel_api
            marvel_public_key = params[:character][:marvel_public_key]
            marvel_private_key = params[:character][:marvel_private_key]

            client = Marvelite::API::Client.new(:public_key => marvel_public_key, :private_key => marvel_private_key)
        end

        def fetch_character
            # Attempts to connect to https://developer.marvel.com/ using provided API keys
            client = connect_to_marvel_api

            response = client.character(@character.name)
        end

        def assign_character_data(response)
            image_path = response["data"]["results"][0]["thumbnail"]["path"]
            image_extension = response["data"]["results"][0]["thumbnail"]["extension"]
            
            # Assign remaining data
            @character.marvel_id = response["data"]["results"][0]["id"]
            @character.image_path = image_path + "/portrait_uncanny." + image_extension
            @character.description = response["data"]["results"][0]["description"]
            @character.modified = response["data"]["results"][0]["modified"]
        end

        def fetch_and_save_comics_from_character(response)
            # Fetch comics
            comics = response["data"]["results"][0]["comics"]["items"]
            for comic in comics do
                begin
                    comic_marvel_id = Integer(comic["resourceURI"].partition("http://gateway.marvel.com/v1/public/comics/").last)

                    response = fetch_comic(response, comic_marvel_id)
                    
                    @comic = assign_comic_data(response, comic_marvel_id)
                    # New comic
                    if @comic.save
                        @occurence = Occurence.new(:character_id => @character.id, :comic_id => @comic.id)
                    # Already have that one.
                    else
                        @requested_comic = Comic.find_by(marvel_id: comic_marvel_id)
                        @occurence = Occurence.new(:character_id => @character.id, :comic_id => @requested_comic.id)
                    end
                    @occurence.save
                rescue Exception => e
                    # Failed to cast from string to Integer. Better not save this comic data.
                    puts e.message
                    next
                end
            end
        end

        def fetch_comic(response, comic_marvel_id)
            client = connect_to_marvel_api

            response = client.comic(comic_marvel_id)
        end

        def assign_comic_data(response, comic_marvel_id)
            image_path = response["data"]["results"][0]["thumbnail"]["path"]
            image_extension = response["data"]["results"][0]["thumbnail"]["extension"]

            comic_title = response["data"]["results"][0]["title"]
            comic_modified = response["data"]["results"][0]["modified"]
            comic_issue_number = Integer(response["data"]["results"][0]["issueNumber"])
            comic_image_path = image_path + "/portrait_uncanny." + image_extension
            comic_description = response["data"]["results"][0]["description"]

            new_comic = Comic.new(
                :title => comic_title,
                :marvel_id => comic_marvel_id,
                :modified => comic_modified,
                :issue_number =>  comic_issue_number,
                :image_path => comic_image_path,
                :description => comic_description
            )
        end
end
