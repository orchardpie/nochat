class AddReadToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :unread, :boolean, null: false, default: false

    reversible do |dir|
      dir.up { change_column_default :messages, :unread, true }
    end
  end
end

