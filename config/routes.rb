Rails.application.routes.draw do
	namespace :api do
    	namespace :v1 do
    		resources :characters
    		resources :comic_books
    	end
    end
end
