class AddForeignKeys < ActiveRecord::Migration[6.0]
  def change
    add_foreign_key :todo_lists, :states
    add_foreign_key :todo_lists, :users, on_delete: :nullify
  end
end
