Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:show]
  resources :projects do
    resources :comments, only: [:create, :destroy]
  end
  resources :comments
end
