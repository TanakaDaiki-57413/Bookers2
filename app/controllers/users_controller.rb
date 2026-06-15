class UsersController < ApplicationController
  # 認証をスキップ: サインアップ（new, create）はログイン前に行うため
  allow_unauthenticated_access only: [:new,:create] 

  def new
    @user = User.new
  end

  def index
    @user = Current.user
    @book = Book.new
  end

  def show
    @user = Current.user
    @book = Book.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    if @user.save
      start_new_session_for @user
      redirect_to after_authentication_url(@user)
    else
      redirect_to root_path
    end
  end

  private
 
  def user_params
    # name, email_address, password, password_confirmation を許可
    params.require(:user).permit(:name, :email_address, :password, :password_confirmation, :profile_image)  
  end
end
