class JoinTodoListWithUsersService < ActiveInteraction::Base
  def execute
    TodoList.joins(:user)
    .select("
      todo_lists.id,
      todo_lists.title,
      todo_lists.description,
      users.user_name,
      users.id AS user_id,
      todo_lists.state,
      todo_lists.deadline"
    )
  end
end