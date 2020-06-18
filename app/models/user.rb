# Table information

# COLUMN NAME  TYPE      IS NULL        DEFAULT

# user_name -> string -> NOT NULL -> --
# email     -> string -> NULL     -> fizmatstepanakert@gmail.com

class User < ApplicationRecord
  has_many :todo_lists
  scope :order_by_name, -> { order('LOWER(user_name)') }
end
