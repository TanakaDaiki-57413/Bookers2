class BookCommentsController < ApplicationController
  def create
    @book = Book.find(params[:book_id])
    comment = Current.user.book_comments.new(book_comment_params)
    comment.book_id = @book.id
    comment.save
  end

  def destroy
    @book = Book.find(params[:book_id])
    @subject_comment = BookComment.find(params[:id])
    BookComment.find(params[:id]).destroy
  end

  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end
end
