class UsersController < ApplicationController
  def index
    if params[:without_pagination]
      render :json => User.all and return
    end
    
    users = GetUsersService.run(
      :per => params[:per],
      :page => params[:page]
    )

    if users.valid?
      render json: users.result
    else
      render json: users.errors, status: 400
    end
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
    if(params[:destroy_all])
      User.destroy_all
    else
      User.where(:id => params[:ids]).destroy_all
    end
    head :no_content
  end

end
