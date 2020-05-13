class UpdateTodoService < ActiveInteraction::Base
  integer :id
  string :title
  string :description 
  integer :user_id
  date :deadline
  string :state

  def execute
    TodoList.update(
      id,
      :title => title,
      :deadline => deadline,
      :description => description,
      :user_id => user_id,
      :state => state
    )
  end
end