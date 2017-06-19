Rails.application.routes.draw do
  get 'session/create'

  devise_for :users
  get 'home/index'
  match '/auth/:provider/callback', to: 'session#create', via: :all
  delete '/logout', to: 'session#destroy', as: :logout
  root to: "home#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
