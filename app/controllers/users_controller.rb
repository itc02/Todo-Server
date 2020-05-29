class UsersController < ApplicationController
  def index
    if params[:without_pagination]
      render :json => User.all and return
    end
    
    users = GetUsersService.run(
      :per => params[:per],
      :page => params[:page],
      :search_string => params[:search_string],
      :filter_criteria => params[:filter_criteria]
    )

    if users.valid?
      render json: users.result
    else
      render json: users.errors, status: 400
    end
  end

  def create
    if !User.find_by(:user_name => params[:user_name])
      result = CreateUserService.run(
        :user_name => params[:user_name],
        :email => params[:email]
      )

      if result.valid?
        UserMailer.new_user(params[:user_name], params[:email]).deliver
        head :no_content
      else
        render :json => result.errors, status: 400
      end
    else
      render :json => { :error => 'User is already created' }
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
