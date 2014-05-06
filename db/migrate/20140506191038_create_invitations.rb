class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.references :message, null: false, index: true
      t.string :token, null: false
      t.timestamps

      t.foreign_key :messages
    end

    add_index :invitations, :token
  end
end

