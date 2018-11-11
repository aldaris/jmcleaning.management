Rails.application.routes.draw do
  root 'invoices#index'

  get 'clients/search(/:name)', to: "clients#search"

  resources :clients do
    get 'card', on: :member
  end

  resources :invoices, :services
end
