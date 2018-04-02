Rails.application.routes.draw do
	namespace :api do
  	namespace :v1 do
  		resources :comic_books
  		resources :characters do
  			get  'characters_elastic',          on: :collection
  			get  'characters_elastic_full',     on: :collection
			end
  	end
  end
end
