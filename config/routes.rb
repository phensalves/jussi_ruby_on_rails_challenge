Rails.application.routes.draw do
  # sidekiq panel
  require 'sidekiq/web'
  mount Sidekiq::Web, at: '/sidekiq'
  get 'sidekiq/copy-data' => 'copy_data#index'

  # front-end
  root to: 'home#index'
  get 'character/:id' => 'home#show', as: :character

  # api
  namespace :api do
    namespace :v1 do
      resources :characters
      get 'characters/search/:keywords' => 'characters#search', as: :characters_search
    end
  end
end
