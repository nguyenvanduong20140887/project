Rails.application.routes.draw do
  resources :reviews
  resources :orders
  resources :line_items
  resources :carts
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users,
    path: '',
    path_names: {sign_in: 'login', sign_out: 'logout', edit: 'profile', sign_up: 'registration'},
    controllers: {omniauth_callbacks: 'omniauth_callbacks', registrations: 'registrations'}

  resources :users, only: [:show]

  resources :products do
    resources :reviews
    resources :likes, only: [:create, :destroy], shallow: true
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'products#index'

  get "search", to: "search#search"
  get "purchase_history", to: "users#purchase_history"
end
