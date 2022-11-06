Rails.application.routes.draw do
  get 'welcome/index'
  root 'welcome#index'
  get 'not_authorized/index'
  # resources :portfolio_managers
  resources :administrators
  get 'sessions/new'
  get 'sessions/create'
  get 'sessions/destroy'
  
  get 'trading/index'

  get 'admin/index'
  post 'admin/createTrader'
  post 'admin/test'
  # resources :traders
  get 'traders/index'
  
  get 'environment_variables/test'
  resources :sessions, only: [:new, :create, :destroy]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resources :portfolio_managers do
    resources :traders
  end
end
