class UsersController < ApplicationController
  allow_unauthenticated_access only: [:new,:create] 
  before_action :is_matching_login_user, only: [:edit, :update]
  before_action :ensure_guest_user, only: [:edit]

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

    @books.each do |book|
      if book.view_counts.empty?
        book.view_counts.add_count_view(book)
      else
        book.view_counts.count_up_view(book)
      end
    end
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

  def follow_list
    user = User.find(params[:id])
    @follow_list =  user.followings
  end

  def follower_list
    user = User.find(params[:id])
    @follower_list = user.followers
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

  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.guest_user?
      redirect_to user_path(Current.user) , notice: "ゲストユーザーはプロフィール編集画面へ遷移できません。"
    end
  end  


end
