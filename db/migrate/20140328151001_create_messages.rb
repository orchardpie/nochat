class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :sender_id, null: false
      t.integer :receiver_id, null: false
      t.integer :word_count, null: false
      t.integer :time_saved, null: false
      t.text :body, null: false

      t.timestamps
    end

    add_foreign_key :messages, :users, column: 'sender_id'
    add_foreign_key :messages, :users, column: 'receiver_id'
    add_index :messages, :sender_id
    add_index :messages, :receiver_id
  end
end

