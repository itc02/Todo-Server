class UserMailer < ApplicationMailer
  def new_user(user_name, email)
    @user_name = user_name
    @email = email
    mail(:to => @email, :subject => 'Welcome to Todo!')
  end

  def new_todo(user)
    @user = user
    @url = 'http://localhost:4000'
    mail(:to => @user.email, :subject => 'You have been assigned')
  end

  def edited_todo(user)
    @user = user
    @url = 'http://localhost:4000'
    mail(:to => @user.email, :subject => 'You have been assigned')
  end
end
