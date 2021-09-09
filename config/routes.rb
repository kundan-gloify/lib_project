Rails.application.routes.draw do
  devise_for :users
  
  
  root to: "home#index"

  resources :libraries

  resources :books

  resources :users

end
