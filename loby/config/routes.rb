Rails.application.routes.draw do
  get 'home/index'
  root to: 'home#index'

  resources :items
  resource :registrations, only: [:new, :create]
  resource :sessions, only: [:new, :create, :destroy]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
