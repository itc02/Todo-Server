class TodosController < ApplicationController
  def index
    todos = GetTodosService.run(
      :per => params[:per],
      :page => params[:page],
      :sorting_criteria => params[:sorting_criteria],
      :order => params[:order]
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
      UserMailer.new_todo(user).deliver
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
      UserMailer.edited_todo(user).deliver
      head :no_content
    else
      render :json => result.errors, status: 400
    end
  end
  
end
