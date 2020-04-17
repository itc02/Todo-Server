class TodosController < ApplicationController
  def index
    render :json => get_paginated_todos
  end

  def create
    User.find(params[:assigned_to]).increment!(:todos_number, 1)
    result = CreateTodoService.run(
      :title => params[:title], 
      :description => params[:description], 
      :assigned_to => params[:assigned_to], 
      :deadline => params[:deadline]
    )
    if result.valid?
      render :json => get_paginated_todos
    else
      head :bad_request
    end
  end

  def destroy
    params[:id].split(',').each do |id|
      User.find(TodoList.find(id).user_id).increment!(:todos_number, -1)
      TodoList.find(id).destroy
    end
    render :json => get_unpaginated_todos
  end

  def update
    if params[:id] != params[:assigned_to]
      User.find(params[:id]).increment(:todos_number, -1)
      User.find(params[:assigned_to]).increment(:todos_number, 1)
    end
    result = UpdateTodoService.run(
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

  def get_paginated_todos
    per = params[:per].to_i
    page = params[:page].to_i

    paginated_todos = todo_list_joined_with_users
    .page(page)
    .per(per)
      
    if paginated_todos.length == 0
      { 
        :todos => get_unpaginated_todos,
        :total_record_count => TodoList.count,
      }
    else
      {
        :todos => paginated_todos,
        :total_record_count => TodoList.count
      }
    end
  end

  def get_unpaginated_todos
    todo_list_joined_with_users.as_json
  end

  def todo_list_joined_with_users
    joined = JoinTodoListWithUsersService.run()
    joined.result
  end
end
