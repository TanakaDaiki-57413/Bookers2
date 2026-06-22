Rails.application.routes.draw do

  root to: "homes#top"
  get "/home/about" => "homes#about"
  # 下記コード記載するとRspecエラーになるのでコメント化
  # get "users/sign_in", to: "sessions#new", as: :new_session

  resource :session
  resources :passwords, param: :token

  resources :users ,path_names: { new: 'sign_up' } do
    resource :relationships, only: [:create,:destroy]
  end

  get "/users/:id/follow_list", to: "users#follow_list", as: :follow_list
  get "/users/:id/follower_list", to: "users#follower_list", as: :follower_list


  resources :books do
    resource :favorite, only: [:create,:destroy]
    resources :book_comments, only: [:create,:destroy]
  end
  get "up" => "rails/health#show", as: :rails_health_check
end
