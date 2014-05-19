class AddIndexToUnreadOnMessages < ActiveRecord::Migration
  def change
    remove_index :messages, column: :receiver_id
    add_index :messages, [:receiver_id, :unread]
  end
end
