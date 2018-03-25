require 'sidekiq/web'

Rails.application.routes.draw do
	resources :comics
	resources :characters
	mount Sidekiq::Web => '/sidekiq'
	namespace 'api' do
		resources :marvel		
  	# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  end
end
