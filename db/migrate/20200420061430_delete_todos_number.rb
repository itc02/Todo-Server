class DeleteTodosNumber < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :todos_number
  end
end
