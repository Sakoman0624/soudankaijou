class UsersController < ApplicationController
  # def index
  #   @users = User.all
  #   @book = Book.new
  #   @user = current_user
  #   @books = Book.all
  # end

  def show
    @room = Room.new
    @user = User.find(params[:id])
  end

  def edit
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to books_path
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

  def confirm
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
