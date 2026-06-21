class BooksController < ApplicationController
  before_action :is_matching_book, only: [:edit, :update]
  def index
    @new_book = Book.new
    @book = Book.new
    @books = Book.all
    @user = Current.user
  end

  def show
    @new_book = Book.new
    @book = Book.find(params[:id])
    @book_comment = BookComment.new
    @user = @book.user
  end

  def edit
    @book = Book.find(params[:id])
  end

  def create
    @book = Current.user.books.new(book_params)
    
    if @book.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book.id)
    else
      @new_book = Book.new
      @user = Current.user
      @books = Book.all
      render:index,status: :unprocessable_entity
    end
  end

  def update

    book = Book.find(params[:id])
    if book.update(book_params)
      flash[:notice]="You have updated book successfully."
      redirect_to book_path(book)
    else
      @book = book
      render:edit,status: :unprocessable_entity
    end

  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

  def is_matching_book
    book = Book.find(params[:id])
    unless book.user.id == Current.user.id
      redirect_to books_path
    end
  end
end
