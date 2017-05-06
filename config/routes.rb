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





  get 'signup' => 'users#new', :as => :signup

   get 'cart' => 'cart#show', :as => :cart
   post 'add_item' => 'cart#add_item'
   post 'edit_quantity' => 'cart#edit_quantity'
   resources :users
 # resources :sessions
   resources :schools
   resources :orders
  
  get 'login' => 'sessions#new', :as => :login
  post 'sessions' => 'sessions#create'
  get 'logout' => 'sessions#destroy', :as => :logout
 

end
