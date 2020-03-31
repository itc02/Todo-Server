class TodosController < ApplicationController
  def index
    render :json => get_all_todos
  end

  def create
    result = HandleTodoService.run(
      :type => 'create', 
      :title => params[:title], 
      :description => params[:description], 
      :assigned_to => params[:assigned_to], 
      :deadline => params[:deadline]
    )
    if result.valid?
      render :json => get_all_todos
    else
      head :bad_request
    end
  end

  def destroy
      TodoList.find(params[:id]).destroy
      render :json => get_all_todos
  end

  def update
    result = HandleTodoService.run(
      :type => 'update',
      :id => params[:id],
      :title => params[:title], 
      :description => params[:description], 
      :assigned_to => params[:assigned_to], 
      :state => params[:state],
      :deadline => params[:deadline]
    )
    if result.valid?
      render :json => get_all_todos
    else
      head :bad_request
    end
  end

  def delete_all
    TodoList.delete_all
    head :ok
  end
  
  def get_owners
    render :json => TodoList.joins(:user).pluck("users.user_name").to_set
  end

  def get_all_todos
    TodoList.joins(:user)
    .select("
      todo_lists.id,
      todo_lists.title,
      todo_lists.description,
      users.user_name,
      users.id AS user_id,
      todo_lists.state,
      todo_lists.deadline")
    .as_json
  end
end
