Rails.application.routes.draw do
  resources :movies
  resources :reviews
  devise_for :users
  root 'movies#index'
end
