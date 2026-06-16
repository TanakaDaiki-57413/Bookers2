class UsersController < ApplicationController
  allow_unauthenticated_access only: [:new,:create] 
  before_action :is_matching_login_user, only: [:edit, :update]

  def new
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
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      start_new_session_for @user
      flash[:notice] = "Welcome! You have signed up successfully."
      redirect_to after_authentication_url(@user)
    else
      render:new,status: :unprocessable_entity
    end
  end

  def update
    user = User.find(params[:id])
    if user.update(user_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to user_path(user)
    else
      @user = user
      render:edit, status: :unprocessable_entity
    end
    
  end

  private
 
  def user_params
    # name, email_address, password, password_confirmation を許可
    params.require(:user).permit(:name,:introduction, :email_address, :password, :password_confirmation, :profile_image)  
  end

  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == Current.user.id
      redirect_to user_path(Current.user)
    end
  end
end
