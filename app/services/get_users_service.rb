class GetUsersService < ActiveInteraction::Base
  integer :per, default: 5
  integer :page, default: 1

  def execute
    users = paginated_users
    if !users.out_of_range?
      { 
        :users => users,
        :total_record_count => User.count,
        :todos_number => user_todos_number
      }
    else 
      { 
        :users => unpaginated_users,
        :total_record_count => User.count,
        :todos_number => user_todos_number
      }
    end
  end

  def paginated_users
    get_users.page(page).per(per)
  end

  def unpaginated_users
    get_users
  end

  def user_todos_number
    get_users.collect do |user|
      TodoList.where(:user_id => user.id).count
    end
  end

  def get_users
    User.select("users.id, users.user_name")
  end
end