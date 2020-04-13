class CreateTodoService < ActiveInteraction::Base
  string :title
  string :description 
  integer :assigned_to
  date :deadline

  def execute
    TodoList.create(
      :title => title,
      :state => 'new',
      :deadline => deadline,
      :description => description,
      :user_id => assigned_to
    )
  end
end