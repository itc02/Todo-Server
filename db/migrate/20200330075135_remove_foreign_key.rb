class RemoveForeignKey < ActiveRecord::Migration[6.0]
  def change
    remove_foreign_key :todo_lists, :states
  end
end
