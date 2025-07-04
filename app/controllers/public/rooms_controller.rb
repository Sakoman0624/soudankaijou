class Public::RoomsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :destroy
  
  def new
    @room = Room.new
  end

  def create
    @room = Room.new(room_params)
    @room.user_id = current_user.id
      if @room.save
        flash[:notice] = "部屋の作成が完了しました"
        redirect_to rooms_path(@rooms)
      else
        render :new
      end
  end

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
    @tags = Tag.all.map do |tag|
      { tag: tag.name, count: tag.rooms.count }
    end
    respond_to do |format|
      format.html
      format.js
    end
   # @room = Room.find(params[:id])
  end

  def show
    @room = Room.find_by(id: params[:id])
    unless @room
      redirect_to rooms_path, alert: "指定された部屋は存在しません"
      return
    end
  
    @comment = Comment.new
    @edit_comment = params[:edit_comment_id] ? @room.comments.find_by(id: params[:edit_comment_id]) : nil
    @user = @room.user_id
    @current_user = current_user
    @comments = @room.comments.where(parent_id: nil).order(:created_at)
  
    if !@room.public? && @room.user != current_user
      redirect_to rooms_path, alert: "この部屋は非公開です"
    end
  end

  def edit
    @room = Room.find(params[:id])
    unless @room.user.id == current_user.id
      redirect_to rooms_path
    end
  end

  def update
    @room = Room.find(params[:id])
    if @room.update(room_params)
      flash[:notice] = "部屋の編集が完了しました"
      redirect_to room_path(@room.id)
    else
      @user = current_user
      @rooms = Room.all
      render :edit
    end
  end

  def destroy
    room = Room.find(params[:id])
    room.destroy
    redirect_to request.referer, notice: 'Room was successfully deleted.'
  end
  
  def toggle_public
    @room = Room.find(params[:id])
    @room.update(public: !@room.public?) # 公開/非公開を反転させる
    redirect_to @room, notice: "公開設定が変更されました。"
  end
  
  def liked_rooms
    @rooms = Room.joins(:likes)
                 .where(likes: { user_id: current_user.id })
                 .distinct
  
    @rooms = case params[:sort]
             when 'likes_desc'
               @rooms.left_joins(:likes)
                     .group(:id)
                     .order('COUNT(likes.id) DESC')
             when 'updated_desc'
               @rooms.order(updated_at: :desc)
             when 'updated_asc'
               @rooms.order(updated_at: :asc)
             when 'created_asc'
               @rooms.order(created_at: :asc)
             else
               @rooms.order(created_at: :desc)
             end
  
    @rooms = @rooms.page(params[:page]).per(12)
  
    respond_to do |format|
      format.html
      format.js
    end
  end




  private
  # ストロングパラメータ
  def room_params
    params.require(:room).permit(:title, :body, :image, :tag_id)
  end
end
