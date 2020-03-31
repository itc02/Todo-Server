class CreateTables < ActiveRecord::Migration[6.0]
  def change
    create_table :todo_lists do |t|
      t.string   :title,       null: false
      t.text     :description, null: false
      t.datetime :deadline,    null: false
      t.integer  :user_id,     null: true
      t.integer :state_id,     null: false
      
      t.timestamps
    end

    create_table :users do |t|
      t.string :user_name, null: false

      t.timestamps
    end

    create_table :states do |t|
      t.string :state_name, null: false

      t.timestamps
    end
  end
end
