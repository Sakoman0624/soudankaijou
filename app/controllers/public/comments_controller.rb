class Public::CommentsController < ApplicationController
  before_action :set_post
  before_action :authenticate_user!


  def create
    @comment = @room.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
      redirect_to request.referer, notice: "コメントを投稿しました。"
    else
      redirect_to request.referer, alert: "コメントの投稿に失敗しました。"
    end
  end

  def destroy
    @comment = @room.comments.find(params[:id])
    if @comment.user == current_user || @room.user == current_user
      @comment.destroy
      redirect_to request.referer, notice: "コメントを削除しました。"
    else
      redirect_to request.referer, alert: "削除権限がありません。"
    end
  end


  private
  def set_post
    @room = Room.find(params[:room_id])
  end

  def comment_params
    params.require(:comment).permit(:body, :image,:room_id)
  end
end
