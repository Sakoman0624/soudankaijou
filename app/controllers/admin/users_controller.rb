class Admin::UsersController < ApplicationController
  layout 'admin'
  before_action :authenticate_admin!
  
  def index
    @users = User.all
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_users_path, notice: 'ユーザーを削除しました。'
  end
  
  def withdraw
    @user = User.find(params[:id])
    # is_deleted を true にして無効化（退会処理）
    if @user.update(is_deleted: true)
      flash[:notice] = 'ユーザーは退会処理されました。'
    else
      flash[:alert] = '退会処理に失敗しました。'
    end
    redirect_to admin_users_path
  end
  
  def reactivate
  @user = User.find(params[:id])
  # is_deleted を false に変更して再有効化
  if @user.update(is_deleted: false)
    flash[:notice] = 'ユーザーは再有効化されました。'
  else
    flash[:alert] = '再有効化に失敗しました。'
  end
  redirect_to admin_users_path
  end
  
end
