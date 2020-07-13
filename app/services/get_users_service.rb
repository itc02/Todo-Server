class GetUsersService < ActiveInteraction::Base
  integer :per, default: 5
  integer :page, default: 1
  string :search_string, default: ''
  string :filter_criterion, default: 'user_name'

  def execute
    return {
      :users => [],
      :total_record_count => 0,
      :todos_number => []
    } if User.count.eql? 0

    users = paginated_users.out_of_range? ? unpaginated_users : paginated_users
    if !search_string
      filtered_users = users
    else
      if filter_criterion == 'all'
        filtered_users = users.where(filter_by_all_where_clause, search: "%#{search_string}%")
      else
        filtered_users = users.where("#{filter_criterion} LIKE ?", "%#{search_string}%")
      end
    end

    {
      :users => filtered_users,
      :total_record_count => User.count,
      :todos_number => user_todos_number
    }
  end

  def filter_by_all_where_clause
    'user_name LIKE :search OR
    email LIKE :search'
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
    User.select("users.id, users.user_name, users.email").order_by_name
  end
end
