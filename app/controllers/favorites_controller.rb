class FavoritesController < ApplicationController
  before_action :logged_in_user

  def create
    @divelog = Divelog.find(params[:divelog_id])
    @user = @divelog.user
    current_user.favorite(@divelog)
    respond_to do |format|
      format.html { redirect_to request.referrer || root_url }
      format.js
    end
  end

  def destroy
    @divelog = Divelog.find(params[:divelog_id])
    current_user.favorites.find_by(divelog_id: @divelog.id).destroy
    respond_to do |format|
      format.html { redirect_to request.referrer || root_url }
      format.js
    end
  end

  def index
    @favorites = current_user.favorites
  end
end



