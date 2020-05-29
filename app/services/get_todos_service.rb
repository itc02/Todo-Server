class GetTodosService < ActiveInteraction::Base
  integer :per, default: 5
  integer :page, default: 1
  string :sorting_criteria, default: 'title'
  string :order, default: 'ASC'
  string :search_string, default: ''
  string :filter_criteria, default: 'title'

  def execute
    todos = paginated_todos.out_of_range? ? unpaginated_todos : paginated_todos
    sorted_todos = order == 'none' ? todos : todos.order("#{sorting_criteria} #{order}")
    filtered_todos = !search_string ? sorted_todos : sorted_todos.where("#{filter_criteria} LIKE ?", "%#{search_string}%")

    {
      :todos =>  filtered_todos,
      :total_record_count => TodoList.count
    }

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