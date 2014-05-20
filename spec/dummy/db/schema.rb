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

ActiveRecord::Schema.define(version: 20140520083510) do

  create_table "chatty_chats", force: true do |t|
    t.string   "user_type"
    t.integer  "user_id"
    t.string   "resource_type"
    t.integer  "resource_id"
    t.boolean  "handled"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "chatty_chats", ["resource_type", "resource_id"], name: "index_chatty_chats_on_resource_type_and_resource_id"
  add_index "chatty_chats", ["user_type", "user_id"], name: "index_chatty_chats_on_user_type_and_user_id"

  create_table "chatty_messages", force: true do |t|
    t.integer  "chat_id"
    t.string   "user_type"
    t.integer  "user_id"
    t.text     "message"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "chatty_messages", ["chat_id"], name: "index_chatty_messages_on_chat_id"
  add_index "chatty_messages", ["user_type", "user_id"], name: "index_chatty_messages_on_user_type_and_user_id"

end
