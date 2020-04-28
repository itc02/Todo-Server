class UsersController < ApplicationController
  def index
    users = PaginateItemsService.run!(
      :items => get_users,
      :per => params[:per],
      :page => params[:page]
    )

    render :json => { 
      :users => users,
      :total_record_count => User.count,
      :todos_number => user_todos_number
    }
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
    User.where(:id => params[:ids]).destroy_all
    render :json => {
      :users => PaginateItemsService.run!(
        :paginate => true,
        :per => params[:per],
        :page => params[:page],
        :items => get_users
      ),
      :total_record_count => User.count,
      :todos_number => user_todos_number
    }
  end

  def get_all_users
    render :json => get_users
  end

  def get_users
    User.select("users.id, users.user_name").order(:user_name)
  end

  def user_todos_number
    get_users.collect do |user|
      TodoList.where(:user_id => user.id).count
    end
  end
end
