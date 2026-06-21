class FavoritesController < ApplicationController
  def create
    book = Book.find(params[:book_id])
    favorite = Current.user.favorites.new(book_id:book.id)
    favorite.save
    redirect_to return_path
  end

  def destroy
    book = Book.find(params[:book_id])
    favorite = Current.user.favorites.find_by(book_id:book.id)
    favorite.destroy
    redirect_to return_path
  end

  private
  def return_path
    case params[:source]
    when "index"
      books_path
    when "show"
      book_path(params[:book_id])
    end
  end
end
