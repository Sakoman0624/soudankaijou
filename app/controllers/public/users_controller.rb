class Public::UsersController < ApplicationController
  # def index
  #   @users = User.all
  #   @book = Book.new
  #   @user = current_user
  #   @books = Book.all
  # end
  
  def show
    @room = Room.new
    @user = User.find(params[:id])
    @user_rooms_count = Room.where(user_id: @user.id).count  # 自作部屋の数として例
    @my_rooms_count = @user.rooms.count                      # 例えば関連付け済みなら
    @liked_rooms_count = @user.liked_rooms.count
  end

  def edit
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to rooms_path
    end
    
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "ユーザー情報の更新に成功しました"
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end

  def check
  end
  
  def withdraw
    @user = User.find(current_user.id)
    # is_deletedカラムをtrueに変更することにより削除フラグを立てる
    @user.update(is_deleted: true)
    # 対象ユーザーがあつかった投稿全てを非公開に
    @user.rooms.update_all(public: false)
    #@room.update(public: !@room.public?)
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to root_path
  end
  
  def unsubscribe
  end

  private
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end


  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to user_path(current_user)
    end
  end
end
