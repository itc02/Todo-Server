class TodosController < ApplicationController
  def index
    render :json => get_paginated_todos
  end

  def create
    result = CreateTodoService.run(
      :title => params[:title], 
      :description => params[:description], 
      :assigned_to => params[:assigned_to], 
      :deadline => params[:deadline]
    )
    if result.valid?
      render :json => get_unpaginated_todos
    else
      head :bad_request
    end
  end

  def destroy
    TodoList.where(:id => params[:id].split(',')).destroy_all
    render :json => get_unpaginated_todos
  end

  def update
    result = EditTodoService.run(
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

  def count
    render :json => { count: TodoList.count }
  end

  def get_paginated_todos
    per = params[:per].to_i
    page = params[:page].to_i

    paginated_todos = todo_list_joined_with_users
    .paginate(
      :page => page, 
      :per_page => per
    )

    if !paginated_todos
      get_unpaginated_todos
    else
      paginated_todos
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
