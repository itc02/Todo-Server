# Table information

# COLUMN NAME    TYPE        NULL        DEFAULT

# user_name        -> string   -> NOT NULL

class User < ApplicationRecord
    has_many :todo_lists
end