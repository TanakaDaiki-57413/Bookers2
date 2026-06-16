class SessionsController < ApplicationController
  allow_unauthenticated_access only: %i[ new create ]
  rate_limit to: 10, within: 3.minutes, only: :create, with: -> { redirect_to new_session_path, alert: "Try again later." }

  def new
  end

  def create
    if user = User.authenticate_by(params.permit(:name, :password))
      start_new_session_for user
      @user = Current.user
      flash[:notice] = "Signed in successfully."
      redirect_to after_authentication_url(@user)
    else
      redirect_to users_sign_in_path, alert: "Try another name or password."
    end
  end

  def destroy
    terminate_session
    flash[:notice]= "Signed out successfully."
    redirect_to root_path, status: :see_other
  end
end
