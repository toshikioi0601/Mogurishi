class CommentsController < ApplicationController
  before_action :logged_in_user

  def create
    @divelog = Divelog.find(params[:divelog_id])
    @user = @divelog.user
    @comment = @divelog.comments.build(user_id: current_user.id, content: params[:comment][:content])
    if !@divelog.nil? && @comment.save
      flash[:success] = "コメントを追加しました！"
      if @user != current_user
        @user.notifications.create(divelog_id: @divelog.id, variety: 2, from_user_id: current_user.id, content: @comment.content) # コメントは通知2
        @user.update_attribute(:notification, true)
      end
    else
      flash[:danger] = "空のコメントは投稿できません。"
    end
    redirect_to request.referrer || root_url
  end

  def destroy
    @comment = Comment.find(params[:id])
    @divelog = @comment.divelog
    if current_user.id == @comment.user_id
      @comment.destroy
      flash[:success] = "コメントを削除しました"
    end
    redirect_to divelog_url(@divelog)
  end
end

