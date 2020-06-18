class GetUsersService < ActiveInteraction::Base
  integer :per, default: 5
  integer :page, default: 1
  string :search_string, default: ''
  string :filter_criterion, default: 'user_name'

  def execute
    users = paginated_users.out_of_range? ? unpaginated_users : paginated_users
    filtered_users = !search_string ? users : users.where("#{filter_criterion} LIKE ?", "%#{search_string}%")
    if !search_string
      filtered_todos = users
    else
      if filter_criterion == 'all'
        filtered_todos = users.where(filter_by_all_where_clause, search: "%#{search_string}%")
      else
        filtered_todos = users.where("#{filter_criterion} LIKE ?", "%#{search_string}%")
      end
    end

    {
      :users => filtered_users,
      :total_record_count => User.count,
      :todos_number => user_todos_number
    }
  end

  def filter_by_all_where_clause
    'user_name LIKE :search'
  end

  def paginated_users
    all_users.page(page).per(per)
  end

  def unpaginated_users
    all_users
  end

  def user_todos_number
    paginated_users.collect do |user|
      TodoList.where(:user_id => user.id).count
    end
  end

  def all_users
    User.select("users.id, users.user_name").order_by_name
  end
end
