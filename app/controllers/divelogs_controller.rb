class DivelogsController < ApplicationController
before_action :logged_in_user
before_action :correct_user, only: [:edit, :update]

  def new
    @divelog = Divelog.new
  end

  def show
    @divelog = Divelog.find(params[:id])
  end

  def destroy
    @divelog = Divelog.find(params[:id])
    if current_user.admin? || current_user?(@divelog.user)
      @divelog.destroy
      flash[:success] = "ダイブログが削除されました"
      redirect_to request.referrer == user_url(@divelog.user) ? user_url(@divelog.user) : root_url
    else
      flash[:danger] = "他人のダイブログは削除できません"
      redirect_to root_url
    end
  end

  def create
    @divelog = current_user.divelogs.build(divelog_params)
    if @divelog.save
      flash[:success] = "ダイブログが登録されました！"
      redirect_to divelog_path(@divelog)
    else
      render 'divelogs/new'
    end
  end

  def edit
    @divelog = Divelog.find(params[:id])
  end

  def update
    @divelog = Divelog.find(params[:id])
    if @divelog.update_attributes(divelog_params)
      flash[:success] = "ダイブログ情報が更新されました！"
      redirect_to @divelog
    else
      render 'edit'
    end
  end

private

  def divelog_params
    params.require(:divelog).permit(:name, :discription, :weather, :temp, :water_temp,
                                   :reference, :depth, :visibility, :popularity)
  end

  def correct_user # 現在のユーザーが更新対象のデータを保有しているかどうか確認
    @divelog = current_user.divelogs.find_by(id: params[:id])
    redirect_to root_url if @divelog.nil?
  end
end
