class AddCountOfTodos < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :todos_number, :integer

  end
end
