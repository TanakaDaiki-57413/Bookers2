class RelationshipsController < ApplicationController
  def create
    user = User.find(params[:user_id])
    Current.user.follow(user)
    redirect_to request.referer
  end

  def destroy
    user = User.find(params[:user_id])
    Current.user.unfollow(user)
    redirect_to request.referer
  end

  def following
    user = User.find(params[:user_id])
    @user = User.followings
  end

  def followers
    user = User.find(params[:user_id])
    @user = user.followers
  end
end
