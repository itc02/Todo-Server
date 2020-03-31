class ChangeColumn < ActiveRecord::Migration[6.0]
  def change
    rename_column :todo_lists, :state_id, :state
    change_column :todo_lists, :state, :string
  end
end
