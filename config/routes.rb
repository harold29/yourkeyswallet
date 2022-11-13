Rails.application.routes.draw do
  resources :transactions
  resources :wallets
  resources :locations
  resources :currencies
  resources :transaction_types
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
