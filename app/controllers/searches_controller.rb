class SearchesController < ApplicationController
  def search
    @keyword = params[:keyword]
    @object = params[:object]
    match = params[:match]
    if @object == "Users"
      @q = user_result(match)
    elsif @object == "Books"
      @q = book_result(match)
    end
  end


  private
  def user_result(match)
    case match
    when "perfect" then
      q = User.ransack(name_eq: params[:keyword])

    when "start" then
      q = User.ransack(name_start: params[:keyword])
      
    when "end" then
      q = User.ransack(name_end: params[:keyword])
      
    when "cont" then
      q = User.ransack(name_cont: params[:keyword])
    end
    return q.result
  end

  def book_result(match)
    case match
    when "perfect" then
      q = Book.ransack(title_eq: params[:keyword])

    when "start" then
      q = Book.ransack(title_start: params[:keyword])
      
    when "end" then
      q = Book.ransack(title_end: params[:keyword])
      
    when "cont" then
      q = Book.ransack(title_cont: params[:keyword])
    end
    return q.result
  end
end
