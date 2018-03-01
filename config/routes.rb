Rails.application.routes.draw do
  # sidekiq panel
  require 'sidekiq/web'
  mount Sidekiq::Web, at: '/sidekiq'
  get 'sidekiq/copy-data' => 'copy_data#index'

  # front-end
  root to: 'home#index'
  get 'character/:character_id' => 'home#show'

  # api
  namespace :api do
    namespace :v1 do
      resources :characters
    end
  end
end
