class GetTodoByIdService < ActiveInteraction::Base
  integer :id

  def execute
    TodoList.find(id)
  end
end
