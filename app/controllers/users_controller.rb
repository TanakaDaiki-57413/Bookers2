class UsersController < ApplicationController
  # 認証をスキップ: サインアップ（new, create）はログイン前に行うため
  allow_unauthenticated_access only: [:new] 

  def new
    @user = User.new
  end

  def index
  end

  def show
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    @user.save
    # 
    # redirect_to ユーザー詳細ページへ 
    redirect_to root_path
  end
end
