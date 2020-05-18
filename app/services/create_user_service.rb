class CreateUserService < ActiveInteraction::Base
  string :user_name
  string :email

  def execute
    User.create(
      :user_name => user_name,
      :email => email
    )
  end
end