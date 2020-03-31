class AddDefaultRecords < ActiveRecord::Migration[6.0]
  def change
    User.create(:id => 1, :user_name => '--')
    ['New', 'In Progress', 'Finished'].each_with_index do |state, index|
      State.create(:id => index + 1, :state_name => state)
    end
  end
end
