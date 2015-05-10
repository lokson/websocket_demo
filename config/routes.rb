Rails.application.routes.draw do
  resources :users, only: [:index]
  root 'home#index'
end
