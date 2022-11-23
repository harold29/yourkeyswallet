Rails.application.routes.draw do

  # resources :profiles, except: [:update, :show, :delete]
  post 'profiles', to: 'profiles#create'
  get 'profile', to: 'profiles#show'
  put 'profiles', to: 'profiles#update'
  patch 'profiles', to: 'profiles#update'

  get 'location', to: 'locations#show'
  post 'locations', to: 'locations#create'


  get 'current_user/index'
  get 'ping', to: 'heartbeat#index'
  resources :transactions
  resources :wallets
  # resources :locations
  resources :currencies
  resources :transaction_types
  devise_for :users, path: '/users', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    registration: 'signup'
  },
  controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
