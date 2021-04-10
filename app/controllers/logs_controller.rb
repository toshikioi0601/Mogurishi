class LogsController < ApplicationController
  before_action :logged_in_user

  def create
    @divelog = Divelog.find(params[:divelog_id])
    @log = @divelog.logs.build(content: params[:log][:content])
    @log.save
    flash[:success] = "メモを追加しました！"
    redirect_to divelog_path(@divelog)
  end

  def destroy
    @log = Log.find(params[:id])
    @divelog = @log.divelog
    if current_user == @divelog.user
      @log.destroy
      flash[:success] = "メモを削除しました"
    end
    redirect_to divelog_url(@divelog)
  end
end
