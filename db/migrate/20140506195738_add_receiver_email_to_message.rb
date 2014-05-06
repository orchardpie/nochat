class AddReceiverEmailToMessage < ActiveRecord::Migration
  def up
    add_column :messages, :receiver_email, :string

    execute(<<-SQL)
      UPDATE messages SET receiver_email = users.email
      FROM users
      WHERE messages.receiver_id = users.id
    SQL

    change_column :messages, :receiver_email, :string, null: false
  end

  def down
    remove_column :messages, :receiver_email
  end
end

