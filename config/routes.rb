Rails.application.routes.draw do

  root to: "homes#top"
  get "/about" => "homes#about"

  resource :session
  resources :passwords, param: :token

  resources :users, only: [:new,:index,:show,:edit] , path_names: { new: 'sign_up' }
  resources :books, only: [:index,:show,:edit]
  
  get "up" => "rails/health#show", as: :rails_health_check
end
