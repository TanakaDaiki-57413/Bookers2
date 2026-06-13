class UsersController < ApplicationController
  # 認証をスキップ: サインアップ（new, create）はログイン前に行うため
  allow_unauthenticated_access only: [:new] 

  def new
  end

  def index
  end

  def show
  end

  def edit
  end
end
