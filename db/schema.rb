# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140520153403) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "devices", force: true do |t|
    t.integer  "user_id",                   null: false
    t.string   "token",                     null: false
    t.boolean  "enabled",    default: true, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "devices", ["user_id"], name: "index_devices_on_user_id", using: :btree

  create_table "invitations", force: true do |t|
    t.integer  "message_id",                   null: false
    t.string   "token",                        null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "responded_to", default: false
  end

  add_index "invitations", ["message_id"], name: "index_invitations_on_message_id", using: :btree
  add_index "invitations", ["token"], name: "index_invitations_on_token", using: :btree

  create_table "messages", force: true do |t|
    t.integer  "sender_id",                     null: false
    t.integer  "receiver_id"
    t.integer  "word_count",                    null: false
    t.integer  "time_saved",                    null: false
    t.text     "body",                          null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "receiver_email",                null: false
    t.boolean  "unread",         default: true, null: false
  end

  add_index "messages", ["receiver_id", "unread"], name: "index_messages_on_receiver_id_and_unread", using: :btree
  add_index "messages", ["sender_id"], name: "index_messages_on_sender_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "authentication_token"
  end

  add_index "users", ["authentication_token"], name: "index_users_on_authentication_token", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "devices", "users", name: "devices_user_id_fk"

  add_foreign_key "invitations", "messages", name: "invitations_message_id_fk"

  add_foreign_key "messages", "users", name: "messages_receiver_id_fk", column: "receiver_id"
  add_foreign_key "messages", "users", name: "messages_sender_id_fk", column: "sender_id"

end
