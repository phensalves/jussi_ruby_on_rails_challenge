require 'sidekiq/web'
Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'

	namespace :api do
  	namespace :v1 do
  		resources :comic_books
  		resources :characters do
  			post  'characters_elastic',          on: :collection
  			post  'characters_elastic_full',     on: :collection
			end
  	end
  end
end
