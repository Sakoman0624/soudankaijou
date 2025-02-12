class RoomsController < ApplicationController
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
        @rooms = Room.all
        render :index
      end
  end

  def index
    # @room = Room.new
    @user = current_user
    @rooms = Room.all
   # @room = Room.find(params[:id])
  end

  def show
    @room = Room.find(params[:id])
    @user = @room.user_id
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
    redirect_to 'rooms'
  end

  private
  # ストロングパラメータ
  def room_params
    params.require(:room).permit(:title, :body, :image)
  end
end
