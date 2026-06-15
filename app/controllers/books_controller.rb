class BooksController < ApplicationController
  def index
    @book = Book.new
    @user = Current.user
  end

  def show
  end

  def edit
  end

  def create
  end

end
