class RemoveNullConsraintFromMessagesReceiverId < ActiveRecord::Migration
  def up
    change_column :messages, :receiver_id, :integer, null: true
  end

  def down
    change_column :messages, :receiver_id, :integer, null: false
  end
end

