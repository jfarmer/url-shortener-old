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

ActiveRecord::Schema.define(version: 20140731081130) do

  create_table "links", force: true do |t|
    t.string   "short_name",               null: false
    t.string   "url",                      null: false
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "clicks_count", default: 0, null: false
    t.integer  "user_id"
  end

  add_index "links", ["short_name"], name: "index_links_on_short_name", unique: true
  add_index "links", ["user_id"], name: "index_links_on_user_id"

  create_table "users", force: true do |t|
    t.string   "email",           null: false
    t.string   "password_digest", null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true

end
