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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130417023650) do

  create_table "group_messages", :force => true do |t|
    t.integer  "user_id"
    t.integer  "group_id"
    t.string   "message"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "group_users", :force => true do |t|
    t.integer  "group_id"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.boolean  "admin"
  end

  create_table "groups", :force => true do |t|
    t.string   "name"
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
    t.boolean  "public",     :default => true
  end

  add_index "groups", ["name"], :name => "index_groups_on_name", :unique => true

  create_table "poll_responses", :force => true do |t|
    t.integer  "poll_id"
    t.integer  "user_id"
    t.string   "response"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "polls", :force => true do |t|
    t.integer  "group_id"
    t.string   "question"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "name"
  end

  add_index "polls", ["name"], :name => "index_polls_on_name"

  create_table "scramble_games", :force => true do |t|
    t.integer  "score"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "scramble_rounds", :force => true do |t|
    t.string   "correctWord"
    t.string   "scrambledWord"
    t.integer  "usedHint"
    t.integer  "roundScore"
    t.integer  "scramble_game_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "phone_number"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "password_digest"
    t.string   "remember_token"
  end

  add_index "users", ["name"], :name => "index_users_on_name", :unique => true
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

end
