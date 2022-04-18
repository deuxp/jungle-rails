Rails.application.routes.draw do

  root to: 'products#index'

  resources :products, only: [:index, :show]
  resources :categories, only: [:show]

  resource :cart, only: [:show] do
    post   :add_item
    post   :remove_item
  end

  resources :orders, only: [:create, :show]

  namespace :admin do
    root to: 'dashboard#show'
    resources :products, except: [:edit, :update, :show]
    resources :categories, except: [:edit, :update, :show, :destroy]
  end

  resources :about, only: [:index]

  # new and create should have same route name to avooid bugs with refreshing the page ? 
  # get 'users', to: 'users#new'
  # post 'users', to: 'users#create'
  # resources :users, only: [ :index, :new, :create]
  resources :users, only: [:new, :create]
  get '/users', to: redirect('/users/new')

  # resources :users, only: [:new] do
  #   post :create
  # end

  # is there a slicker way to have custom REST endpoints and path helpers
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy'
  
end
