class Admin::RoomsController < ApplicationController
  layout 'admin'
  before_action :authenticate_admin!
  
  def index
    # @room = Room.new
    @user = current_user
    @rooms = Room.where(public: true)
    # 並び順切り替え
    case params[:sort]
    when 'likes_desc'
      @rooms = @rooms.left_joins(:likes).group(:id).order('COUNT(likes.id) DESC')
    when 'updated_desc'
      @rooms = @rooms.order(updated_at: :desc)
    when 'updated_asc'
      @rooms = @rooms.order(updated_at: :asc)
    when 'created_desc'
      @rooms = @rooms.order(created_at: :desc)
    when 'created_asc'
      @rooms = @rooms.order(created_at: :asc)
    else
      @rooms = @rooms.order(created_at: :desc) # デフォルト：新しい順
    end
    @rooms = @rooms.page(params[:page]).per(12)
   # @room = Room.find(params[:id])
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
    @rooms = Room.all
  end
end
