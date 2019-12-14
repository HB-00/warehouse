Rails.application.routes.draw do
  root 'cargos#index'
  resources :users
  resources :cargos
  resources :io_logs, only: [:new, :create, :index]
  get 'login', to: 'sessions#new', as: :login
  delete 'logout', to: 'sessions#destroy', as: :logout
  get 'signup', to: 'users#new', as: :signup
  resources :sessions, only: [:create]
  resources :users
  resources :user_cargos, only: :index

    
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
