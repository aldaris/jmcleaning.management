Rails.application.routes.draw do
  root 'home#index'

  resources :clients, :addresses
end
