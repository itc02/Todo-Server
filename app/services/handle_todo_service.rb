class HandleTodoService < ActiveInteraction::Base
  string :type
  integer :id, default: nil
  string :title
  string :description 
  integer :assigned_to
  string :state, default: nil
  date :deadline

  def execute
    case type
    when 'create'
      create_todo
    when 'update'
      update_todo
    end
  end

  def create_todo
    TodoList.create(
      :title => title,
      :state => 'new',
      :deadline => deadline,
      :description => description,
      :user_id => assigned_to
    )
  end

  def update_todo
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