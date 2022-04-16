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

  resources :users, only: [:new, :create]

  # is there a slicker way to have custom REST endpoints and path helpers
  delete 'logout', to: 'sessions#destroy', as: :logout
  get 'login', to: 'sessions#new', as: :new_session
  post 'login', to: 'sessions#create'
  
end
