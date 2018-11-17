Rails.application.routes.draw do
  devise_for :users
  root 'home#hello'
end
