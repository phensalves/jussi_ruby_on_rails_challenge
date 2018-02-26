Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api, path: '/' do

    namespace :v1, path: '/' do
      resources :characters, only: [:index, :show, :create, :update, :destroy]
      resources :comics, only: [:index, :show, :create, :update, :destroy]
    end

  end
end
