class UpdateTodoService < ActiveInteraction::Base
  integer :id
  string :title
  string :description 
  integer :assigned_to
  date :deadline
  string :state

  def execute
    TodoList.update(
      id,
      :title => title,
      :deadline => deadline,
      :description => description,
      :user_id => assigned_to,
      :state => state
    )
  end
end