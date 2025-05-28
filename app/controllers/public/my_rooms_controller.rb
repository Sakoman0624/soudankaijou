class Public::MyRoomsController < ApplicationController
  def index
    @rooms = current_user.rooms.page(params[:page]).per(12)
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
    respond_to do |format|
      format.html
      format.js
    end
  end
end
