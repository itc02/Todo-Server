class TodosController < ApplicationController
  def index
    todos = GetTodosService.run(
      :per => params[:per],
      :page => params[:page],
    )

    if todos.valid?
      render json: todos.result
    else
      render json: service.errors, status: 400
    end
  end

  def create
    result = CreateTodoService.run(
      :title => params[:title], 
      :description => params[:description], 
      :assigned_to => params[:assigned_to],
      :deadline => params[:deadline]
    )
    if result.valid?
      head :no_content
    else
      render :json => service.errors, status: 400
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
    result = UpdateTodoService.run(
      :id => params[:id],
      :title => params[:title], 
      :description => params[:description], 
      :assigned_to => params[:assigned_to], 
      :state => params[:state],
      :deadline => params[:deadline]
    )
    
    if result.valid?
      head :no_content
    else
      render :json => service.errors, status: 400
    end
  end
  
end
