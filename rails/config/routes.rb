Rails.application.routes.draw do
  root 'invoices#index'

  get 'clients/search(/:name)', to: 'clients#search'

  resources :clients do
    get 'card', on: :member
  end

  resources :services do
    put 'duplicate', on: :member
    put 'inactivate', on: :member
  end

  resources :invoices do
    put 'mark-as-paid', on: :member
  end
  resources :services
end
