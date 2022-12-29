Rails.application.routes.draw do
  get 'not_found/index'
  get 'administrator_profile/index'
  patch 'administrator_profile/update'
  get 'portfolio_manager_profile/index'
  patch 'portfolio_manager_profile/update'
  get 'trader_profile/index'
  patch 'trader_profile/update'
  get 'welcome/index'
  root 'welcome#index'
  get 'not_authorized/index'
  # resources :portfolio_managers
  resources :administrators

  post 'sessions/create'
  get 'sessions/destroy'

  get 'trading/index'
  get 'trading/autocomplete/:q', to: 'trading#autocomplete_symbol'
  get 'trading/getIntraPrices', to: 'trading#getIntraPrices'
  post 'trading/addFavoriteStock', to: 'trading#add_favorite_stock', via: :post, as: :add_favorite_stock
  post 'trading/removeFavoriteStock', to: 'trading#remove_favorite_stock', via: :delete, as: :remove_favorite_stock

   # resources :traders
  # get 'traders/index'

  resources :sessions, only: %i[new create destroy]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resources :portfolio_managers do
    resources :traders
  end
end
