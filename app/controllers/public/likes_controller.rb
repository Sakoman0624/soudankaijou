class Public::LikesController < ApplicationController
  before_action :authenticate_user!
  
  def create
    @room = Room.find(params[:room_id])
    return unless @room.public? # 非公開の部屋はいいねできない
    current_user.likes.create(room: @room)
    redirect_to request.referer
  end
  
  def destroy
    @room = Room.find(params[:room_id])
    current_user.likes.find_by(room: @room)&.destroy
    redirect_to request.referer
  end
end
