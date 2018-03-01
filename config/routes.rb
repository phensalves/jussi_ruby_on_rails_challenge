Rails.application.routes.draw do
  # sidekiq panel
  require 'sidekiq/web'
  mount Sidekiq::Web, at: '/sidekiq'

  # api routes
  root to: 'test#index'
end
