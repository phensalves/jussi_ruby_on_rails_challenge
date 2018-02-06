Rails.application.routes.draw do
  get 'home/index'

  resources :characters, only: [:index, :new, :create, :show]
  resources :comics, only: [:index, :show]

  get "search", to: "search#search"
  get "search_error", to: "search#error"

  root 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
