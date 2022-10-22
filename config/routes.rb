Rails.application.routes.draw do
  #TODO: Remove this once the platform has the admin page developed and login is enabled
  root 'admin#index'
  
  get 'trading/index'

  get 'admin/index'
  post 'admin/createTrader'
  
  resources :traders
  # get 'trader/index'
  
  get 'environment_variables/test'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
