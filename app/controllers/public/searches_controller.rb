class Public::SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    @range = params[:range]
  
    if params[:tag].present?
      @rooms = Room.joins(:tag).where(tags: { name: params[:tag] }, public: true)
    elsif @range == "作成者名"
      @rooms = Room.joins(:user).merge(User.looks(params[:search], params[:word])).where(public: true)
    else
      @rooms = Room.looks(params[:search], params[:word]).where(public: true)
    end
  
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
  
    respond_to do |format|
      format.html
      format.js
    end
  end
end
