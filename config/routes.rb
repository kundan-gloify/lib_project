Rails.application.routes.draw do
  get 'users/index'
  get 'users/show'
  get 'users/new'
  get 'users/edit'
  devise_for :users
  
  root to: "home#index"

  resources :libraries

  resources :books

  resources :users

end
