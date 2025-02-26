class Public::MyRoomsController < ApplicationController
  def index
    @rooms = current_user.rooms.page(params[:page]).per(12)
  end
end
