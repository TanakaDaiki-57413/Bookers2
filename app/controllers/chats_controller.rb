class ChatsController < ApplicationController
  before_action :block_non_related_users, only: [:show]

  def show
    @user = User.find(params[:id])
    
    rooms = Current.user.user_rooms.pluck(:room_id)

    user_rooms = UserRoom.find_by(user_id: @user.id, room_id: rooms)
    
    unless user_rooms.nil?
      @room = user_rooms.room
    else
      @room = Room.new
      @room.save

      UserRoom.create(user_id: Current.user.id, room_id: @room.id)
      UserRoom.create(user_id: @user.id, room_id: @room.id)

    end

    @chats = @room.chats

    @chat = Chat.new(room_id: @room.id)

  end

  def create
    @chat = Current.user.chats.new(chat_params)

    @chat.save

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to request.referrer }
    end
  end

  def destroy
    @chat = Current.user.chats.find(params[:id])
    @chat.destroy

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to request.referrer }
    end
  end

  private

  def chat_params
    params.require(:chat).permit(:message, :room_id)
  end

  def block_non_related_users
    user = User.find(params[:id])

    unless Current.user.following?(user) && user.following?(Current.user)
      redirect_to books_path
    end
  end

end
