class Public::RoomsController < ApplicationController
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
        @user = current_user
        @rooms = Room.where(public: true).page(params[:page]).per(12)
        render :index
      end
  end

  def index
    # @room = Room.new
    @user = current_user
    @rooms = Room.where(public: true).page(params[:page]).per(12)
   # @room = Room.find(params[:id])
  end

  def show
    @room = Room.find(params[:id])
    @comment = Comment.new
    @user = @room.user_id
    @current_user = current_user
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
    redirect_to request.referer
  end
  
  def toggle_public
    @room = Room.find(params[:id])
    @room.update(public: !@room.public?) # 公開/非公開を反転させる
    redirect_to @room, notice: "公開設定が変更されました。"
  end
  
  def liked_rooms
    @liked_rooms = Room.where(public: true).where(id: current_user.liked_rooms.pluck(:room_id)).page(params[:page]).per(12)
  end

  private
  # ストロングパラメータ
  def room_params
    params.require(:room).permit(:title, :body, :image)
  end
end
