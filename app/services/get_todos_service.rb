class GetTodosService < ActiveInteraction::Base
  integer :per, default: 5
  integer :page, default: 1
  string :sorting_criteria, default: 'title'
  string :order, default: 'ASC'

  def execute
    todos = paginated_todos
    if !todos.out_of_range?
      { 
        :todos => order == 'none' ? todos : todos.order("#{sorting_criteria} #{order}"),
        :total_record_count => TodoList.count
      }
    else 
      { 
        :todos => unpaginated_todos,
        :total_record_count => TodoList.count
      }
    end
  end

  def paginated_todos
    todo_list_joined_with_users.page(page).per(per)
  end

  def unpaginated_todos
    todo_list_joined_with_users.as_json
  end

  def todo_list_joined_with_users
    joined = JoinTodoListWithUsersService.run()
    joined.result
  end

end