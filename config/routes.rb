Rails.application.routes.draw do
  root 'home#index'

  resources :clients do
    get 'search/:name', to: "clients#search", on: :collection
    get 'card', on: :member
  end

  resources :invoices, :prices
end
