class TodosController < ApplicationController
  def index
    if params[:all_todos_id]
      render :json => GetAllTodosIdService.run!() and return
    end

    if params[:id]
      render :json => GetTodoByIdService.run!(:id => params[:id]) and return
    end

    todos = GetTodosService.run(
      :per => params[:per],
      :page => params[:page],
      :sorting_criteria => params[:sorting_criteria],
      :order => params[:order],
      :search_string => params[:search_string],
      :filter_criteria => params[:filter_criteria]
    )

    if todos.valid?
      render :json => todos.result
    else
      render :json => result.errors, status: 400
    end
  rescue => err
    render :json => { :error => err }
  end

  def create
    user = User.find(params[:user_id])

    result = CreateTodoService.run(
      :title => params[:title], 
      :description => params[:description], 
      :user_id => params[:user_id],
      :deadline => params[:deadline]
    )
    if result.valid?
      UserMailer.assign_todo(user).deliver
      head :no_content
    else
      render :json => result.errors, status: 400
    end
  end

  def destroy
    if(params[:destroy_all])
      TodoList.destroy_all
    else
      TodoList.where(:id => params[:ids]).destroy_all
    end
    head :no_content
  end

  def update
    user = User.find(params[:user_id])
    result = UpdateTodoService.run(
      :id => params[:id].to_i,
      :title => params[:title], 
      :description => params[:description], 
      :user_id => params[:user_id].to_i,
      :state => params[:state],
      :deadline => params[:deadline]
    )
    
    if result.valid?
      UserMailer.assign_todo(user).deliver
      head :no_content
    else
      render :json => result.errors, status: 400
    end
  end
  
end
