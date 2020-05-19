class GetUsersService < ActiveInteraction::Base
  integer :per, default: 5
  integer :page, default: 1
  string :search_string, default: ''
  string :search_criteria, default: 'user_name'

  def execute
    users = paginated_users.out_of_range? ? unpaginated_users : paginated_users
    filtered_users = !search_string ? users : users.where("#{search_criteria} LIKE ?", "%#{search_string}%")

    {
      :users => filtered_users,
      :total_record_count => User.count,
      :todos_number => user_todos_number
    }
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
    User.select("users.id, users.user_name").order(:user_name)
  end
end