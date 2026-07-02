class BooksController < ApplicationController
  before_action :is_matching_book, only: [:edit, :update]
  def index
    @new_book = Book.new
    @books = Book.popular_in_last_week
    @user = Current.user
    
    @books.each do |book|
      if book.view_counts.empty?
        book.view_counts.add_count_view(book)
      else
        book.view_counts.count_up_view(book)
      end
    end

  end

  def show
    @new_book = Book.new
    @book = Book.find(params[:id])
    @book_comment = BookComment.new
    @user = @book.user

    if @book.view_counts.empty?
      @book.view_counts.add_count_view(@book)
    else
      @book.view_counts.count_up_view(@book)
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def create
    @new_book = Current.user.books.new(book_params)
    
    if @new_book.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@new_book.id)
    else
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
