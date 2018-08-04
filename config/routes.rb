Rails.application.routes.draw do
  get 'clients/show'
  root 'home#index'

  resources :clients, :addresses
end
