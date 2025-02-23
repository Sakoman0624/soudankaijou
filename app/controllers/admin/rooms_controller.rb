class Admin::RoomsController < ApplicationController
  layout 'admin'
  before_action :authenticate_admin!
  def index
    @user = current_admin
    @rooms = Room.all.page(params[:page]).per(12)
  end
  def destroy
    @room = Room.find(params[:id])
    @room.destroy
    redirect_to admin_rooms_path, notice: 'ルームを削除しました。'
  end
  
  def show
    @room = Room.find(params[:id])
    @comment = Comment.new
    @user = @room.user_id
    @current_user = current_admin
  end
end
