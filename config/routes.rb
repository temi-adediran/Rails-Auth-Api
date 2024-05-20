Rails.application.routes.draw do
  resources :purchases
  resources :albums
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  post '/login' => 'accounts#login'
  post '/signup' => 'accounts#signup'
  post '/logout' => 'accounts#logout'
end

# == Route Map
#
