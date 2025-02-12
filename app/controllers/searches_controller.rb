class SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    @range = params[:range]
    @rooms = Room.looks(params[:search], params[:word])

  end
end
