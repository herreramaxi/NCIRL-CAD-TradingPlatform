Rails.application.routes.draw do
  get 'admin/index'
  root 'trader#index'
  get 'trader/index'
  get 'environment_variables/test'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
