class GiveDefaultValueToTodosCount < ActiveRecord::Migration[6.0]
  def change
    change_column_default :users, :todos_number, 0
  end
end
