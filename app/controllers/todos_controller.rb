class TodosController < ApplicationController
  def index
    todos = PaginateItemsService.run!(
      :per => params[:per],
      :page => params[:page],
      :items => todo_list_joined_with_users
    )

    render :json => { 
      :todos => todos.order("#{params[:sorting_criteria]} #{params[:order]}"),
      :total_record_count => TodoList.count
    }
    
  end

  def create
    result = CreateTodoService.run(
      :title => params[:title], 
      :description => params[:description], 
      :assigned_to => params[:assigned_to],
      :deadline => params[:deadline]
    )
    if result.valid?
      render :json => {
        :todos => PaginateItemsService.run!(
          :paginate => true,
          :per => params[:per],
          :page => params[:page],
          :items => todo_list_joined_with_users
        ),
        :total_record_count => TodoList.count
      }
    else
      head :bad_request
    end
  end

  def destroy
    TodoList.where(:id => params[:ids]).destroy_all
    render :json => {
      :todos => PaginateItemsService.run!(
        :paginate => true,
        :per => params[:per],
        :page => params[:page],
        :items => todo_list_joined_with_users
      ),
      :total_record_count => TodoList.count
    }
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
      render :json => {
        :todos => PaginateItemsService.run!(
          :paginate => true,
          :per => params[:per],
          :page => params[:page],
          :items => todo_list_joined_with_users
        ),
        :total_record_count => TodoList.count
      }
    else
      head :bad_request
    end
  end

  def delete_all
    TodoList.delete_all
    head :ok
  end

  def todo_list_joined_with_users
    joined = JoinTodoListWithUsersService.run()
    joined.result
  end
end
