Rails.application.routes.draw do
  get 'home/index'

  resources :characters, only: [:index, :new, :create, :show]
  resources :comics, only: [:index, :show]
  
  get "api/characters", to: "api#characters", as: "api_characters"
  get "api/characters/:id", to: "api#character", as: "api_character"
  get "api/comics", to: "api#comics", as: "api_comics"
  get "api/comics/:id", to: "api#comic", as: "api_comic"
  get "api/search/", to: "api#search", as: "api_search"

  get "search", to: "search#search"
  get "search_error", to: "search#error"

  root 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
