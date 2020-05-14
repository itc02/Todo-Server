class CreateTodoService < ActiveInteraction::Base
  string :title
  string :description 
  integer :user_id
  date :deadline

  def execute
    TodoList.create(
      :title => title,
      :state => 'new',
      :deadline => deadline,
      :description => description,
      :user_id => user_id
    )
  end
end