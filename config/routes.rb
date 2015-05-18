Rails.application.routes.draw do
  resources :users
  # match 'live/create' => 'live#create', via: :get
  root 'home#index'
end
