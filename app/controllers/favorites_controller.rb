class FavoritesController < ApplicationController
  def create
    @book = Book.find(params[:book_id])
    favorite = Current.user.favorites.new(book_id:@book.id)
    favorite.save
    @book.reload
  end

  def destroy
    @book = Book.find(params[:book_id])
    favorite = Current.user.favorites.find_by(book_id:@book.id)
    favorite.destroy
    @book.reload
  end


end
