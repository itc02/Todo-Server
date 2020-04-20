class UsersController < ApplicationController
  def index
    render :json => get_all_users
  end

  def create
    if !User.find_by(:user_name => params[:user_name])
      User.create(:user_name => params[:user_name])
      render :json => { isOkay: true }
    else
      render :json => { isOkay: false }
    end
  end

  def destroy
    User.where(:id => params[:id].split(',')).destroy_all
    render :json => get_all_users
  end

  def get_all_users
    User.select("users.id, users.user_name")
  end
end
