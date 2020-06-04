class GetAllTodosIdService < ActiveInteraction::Base
  def execute
    TodoList.select('id').map{ |ids| ids.id }
  end
end