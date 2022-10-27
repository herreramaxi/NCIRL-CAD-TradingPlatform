Rails.application.routes.draw do
  resources :administrators
  get 'sessions/new'
  get 'sessions/create'
  get 'sessions/destroy'
  #TODO: Remove this once the platform has the admin page developed and login is enabled
  root 'admin#index'
  
  get 'trading/index'

  get 'admin/index'
  post 'admin/createTrader'
  post 'admin/test'
  # resources :traders
  # get 'trader/index'
  
  get 'environment_variables/test'
  resources :sessions, only: [:new, :create, :destroy]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resources :administrators do
    resources :traders
  end
end
