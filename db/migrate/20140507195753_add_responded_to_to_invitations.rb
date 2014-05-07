class AddRespondedToToInvitations < ActiveRecord::Migration
  def change
    add_column :invitations, :responded_to, :boolean, default: false
  end
end
