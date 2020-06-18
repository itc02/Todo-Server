class GetTodosService < ActiveInteraction::Base
  integer :per, default: 5
  integer :page, default: 1
  string :sorting_criteria, default: 'title'
  string :order, default: 'ASC'
  string :search_string, default: ''
  string :filter_criteria, default: 'title'

  def execute
    if TodoList.count.eql? 0
      return {
        :todos => [],
        :total_record_count => 0
      }
    end

    todos = paginated_todos.out_of_range? ? unpaginated_todos : paginated_todos
    sorted_todos = order == 'none' ? todos : todos.order("#{sorting_criteria} #{order}")
    if !search_string
      filtered_todos = sorted_todos
    else
      if filter_criteria == 'all'
        filtered_todos = sorted_todos.where(filter_by_all_where_clause, search: "%#{search_string}%")
      else
        filtered_todos = sorted_todos.where("#{filter_criteria} LIKE ?", "%#{search_string}%")
      end
    end


    {
      :todos =>  filtered_todos,
      :total_record_count => TodoList.count
    }

  end

  def filter_by_all_where_clause
    'title LIKE :search OR 
    deadline LIKE :search OR 
    state LIKE :search OR 
    user_name LIKE :search'
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
