# Table information

# COLUMN NAME    TYPE        IS NULL     DEFAULT    

# title       -> string   -> NOT NULL ->   --
# description -> string   -> NOT NULL ->   --
# deadline    -> DateTime -> NOT NULL ->   --
# user_id     -> integer  -> NULL     ->   --
# state       -> string   -> NOT NULL ->   --

# foreign_key TO users

class TodoList < ApplicationRecord
  belongs_to :user
  validates :state, inclusion: { in: ['new', 'in progress', 'finished'] }
end