class UsersController < ApplicationController
  # 認証をスキップ: サインアップ（new, create）はログイン前に行うため
  allow_unauthenticated_access only: [:new,:create] 

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

  private
 
  def user_params
    # name, email_address, password, password_confirmation を許可
    params.require(:user).permit(:name, :email_address, :password, :password_confirmation, :profile_image)  
  end
end
