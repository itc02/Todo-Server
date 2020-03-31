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
    params[:id].split(',').each do |id|
      User.find(id).destroy
    end
    TodoList.where(:user_id => nil).update_all(:user_id => 1)
    render :json => get_all_users
  end

  def get_all_users
    User.select("users.id, users.user_name").drop(1)
  end
end
