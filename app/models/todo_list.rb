# Table information

# COLUMN NAME    TYPE        IS NULL        

# title       -> string   -> NOT NULL
# description -> string   -> NOT NULL 
# deadline    -> DateTime -> NOT NULL
# user_id     -> integer  -> NULL
# state       -> string   -> NOT NULL

class TodoList < ApplicationRecord
    belongs_to :user
    validates :state, inclusion: { in: ['new', 'in progress', 'finished'] }
end