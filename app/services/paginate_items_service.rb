class PaginateItemsService < ActiveInteraction::Base
  integer :per, default: nil
  integer :page, default: nil
  boolean :paginate, default: false
  array :items

  def execute
    todos = paginated_todos
    if paginate || !todos.out_of_range?
      todos
    else 
      unpaginated_todos
    end
  end

  def paginated_todos
    items.page(page).per(per)
  end

  def unpaginated_todos
    items.as_json
  end

end