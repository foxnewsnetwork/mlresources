Rails.application.routes.draw do

  root 'apiv1/home#index'
  namespace :apiv1 do
    resources :products, only: [:show], controller: 'products/show'
    resources :products, only: [:destroy], controller: 'products/destroy'
    resources :products, only: [:index], controller: 'products/index'
    resource :product_metadatum, only: [:show], controller: 'product_metadatum/show'
    resource :product_metadata, only: [:show], controller: 'product_metadatum/show'
    resources :pictures, only: [:show], controller: 'pictures/show'
    resources :pictures, only: [:destroy], controller: 'pictures/destroy'
    resources :taxons, only: [:index], controller: 'taxons/index'
    resources :taxons, only: [:show], controller: 'taxons/show'
    resources :taxons, only: [:destroy], controller: 'taxons/destroy'
    resources :taxons, only: [:update], controller: 'taxons/update'
    resources :employees, only: [:show], controller: 'employees/show'
    resources :employees, only: [:index], controller: 'employees/index'
    resources :translations, only: [:show], controller: 'translations/show'
    resources :translations, only: [:index], controller: 'translations/index'
    resources :translations, only: [:create], controller: 'translations/create'
    resources :translations, only: [:update], controller: 'translations/update'
    resources :i18n_translations, only: [:index], controller: 'i18n_translations/index'
    resources :messages, only: [:create], controller: 'messages/create'
    resources :messages, only: [:index], controller: 'messages/index'
    resources :users, only: [:create], controller: 'users/create'
    resources :users, only: [:show], controller: 'users/show'
    resources :offers, only: [:create], controller: 'offers/create'
    resources :offers, only: [:show], controller: 'offers/show'
    resources :offers, only: [:destroy], controller: 'offers/destroy'
    resources :offers, only: [:index], controller: 'offers/index'
    resources :contacts, only: [:create], controller: 'contacts/create'
    resources :contacts, only: [:update], controller: 'contacts/update'
    resources :contacts, only: [:destroy], controller: 'contacts/destroy'
    resources :contacts, only: [:index], controller: 'contacts/index'
    resources :contacts, only: [:show], controller: 'contacts/show'
  end

  namespace :users do
    resources :users_offers, only: [:create], controller: 'offers/create'

    resources :users_products, only: [:create], controller: 'products/create'
    resources :users_products, only: [:update], controller: 'products/update'
  end

  namespace :admin do
    resources :admin_products, only: [:create], controller: 'products/create'
    resources :admin_products, only: [:update], controller: 'products/update'
    
    resources :admin_employees, only: [:create], controller: 'employees/create'

    resources :admin_taxons, only: [:create], controller: 'taxons/create'
    resources :taxons, only: [:update], controller: 'taxons/update'

    resources :admin_sessions, only: [:create], controller: 'sessions/create'
    resources :admin_sessions, only: [:destroy], controller: 'sessions/destroy'
  end
end
