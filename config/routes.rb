Rails.application.routes.draw do
  
  # Routes for main resources
  resources :items
  resources :purchases
  resources :item_prices

  # Semi-static page routes
  get 'home' => 'home#home', as: :home
  get 'about' => 'home#about', as: :about
  get 'contact' => 'home#contact', as: :contact
  get 'privacy' => 'home#privacy', as: :privacy
  
  # Set the root url
  root :to => 'home#home'  


  #Catch edgecase for person refreshing page after failing to create user
  get 'users' => 'users#new', :as => :signupcatch


  get 'signup' => 'users#new', :as => :signup
  get 'users/new' => 'users#new', :as => :new_user
  get 'user/edit' => 'users#edit', :as => :edit_current_user
  post 'users' => 'users#create'
  patch 'users/:id' => 'users#update'

 # resources :users
 # resources :sessions
   resources :schools
   resources :orders
  
  get 'login' => 'sessions#new', :as => :login
  post 'sessions' => 'sessions#create'
  get 'logout' => 'sessions#destroy', :as => :logout



end
