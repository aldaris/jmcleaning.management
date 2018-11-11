Rails.application.routes.draw do
  root 'invoices#index'

  get 'clients/search(/:name)', to: "clients#search"

  resources :clients do
    get 'card', on: :member
    collection do
      delete :remove
    end
  end

  resources :invoices, :services
end
