class AddEmailColumn < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :email, :string, :default => 'fizmatstepanakert@gmail.com'
  end
end
