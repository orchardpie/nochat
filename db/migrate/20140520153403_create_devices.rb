class CreateDevices < ActiveRecord::Migration
  def change
    create_table :devices do |t|
      t.references :user, null: false, index: true
      t.foreign_key :users
      t.string :token, null: false
      t.boolean :enabled, null: false, default: true

      t.timestamps
    end
  end
end
