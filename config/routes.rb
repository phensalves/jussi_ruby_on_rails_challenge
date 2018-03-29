Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  root to: 'home#index'
  resources :characters, only: [:index, :show] do
    resources :comics, only: [:index]
    collection do
     get 'search'
    end
  end
end
