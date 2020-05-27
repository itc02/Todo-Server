class GetAllUsersIdService < ActiveInteraction::Base
  def execute
    User.select('id').map{ |ids| ids.id }
  end
end