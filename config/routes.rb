Rails.application.routes.draw do

  root to: "homes#top"
  get "/about" => "homes#about"
  get "/users/sign_in" => "sessions#new" 

  resource :session, only: [:edit,:show,:update,:destroy,:create]
  resources :passwords, param: :token

  resources :users, only: [:new,:index,:show,:edit,:create],path_names: { new: 'sign_up' }
  resources :books
  
  get "up" => "rails/health#show", as: :rails_health_check
end
