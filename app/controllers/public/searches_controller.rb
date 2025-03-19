class Public::SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    @range = params[:range]
    
    if @range == "User"
      @users = User.looks(params[:search], params[:word]).where(public: true).order(created_at: :desc).page(params[:page]).per(20)
    else
      @rooms = Room.looks(params[:search], params[:word]).where(public: true).order(created_at: :desc).page(params[:page]).per(12)
    end

  end
end
