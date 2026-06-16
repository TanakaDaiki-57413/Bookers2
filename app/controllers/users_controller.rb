class UsersController < ApplicationController
  # 認証をスキップ: サインアップ（new, create）はログイン前に行うため
  allow_unauthenticated_access only: [:new,:create] 

  def new
    @new_book = Book.new
    @user = User.new
  end

  def index
    @new_book = Book.new
    @users = User.all
    @user = Current.user
  end

  def show
    @new_book = Book.new
    @user = User.find(params[:id])
    @books = Book.where(user_id: @user.id)
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
