Rails.application.routes.draw do
  root 'cargos#index'
  resources :users
  resources :cargos
  get 'login', to: 'sessions#new', as: :login
  delete 'logout', to: 'sessions#destroy', as: :logout
  get 'signup', to: 'users#new', as: :signup
  root 'home#index'
  resources :sessions, only: [:create]
  resources :users
    
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
