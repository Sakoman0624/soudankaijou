class Admin::DashboardsController < ApplicationController
  layout 'admin'
  before_action :authenticate_admin!
  def index
    @room_count = Room.count #部屋の合計数
    @user_count = User.count #ユーザーの合計数
  end
end
