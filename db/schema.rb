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

ActiveRecord::Schema.define(version: 20140228005021) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: true do |t|
    t.integer  "user_id",           null: false
    t.integer  "link_id",           null: false
    t.integer  "parent_comment_id"
    t.string   "body",              null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["link_id"], name: "index_comments_on_link_id", using: :btree
  add_index "comments", ["parent_comment_id"], name: "index_comments_on_parent_comment_id", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "link_subs", force: true do |t|
    t.integer  "sub_id"
    t.integer  "link_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "link_subs", ["link_id"], name: "index_link_subs_on_link_id", using: :btree
  add_index "link_subs", ["sub_id"], name: "index_link_subs_on_sub_id", using: :btree

  create_table "links", force: true do |t|
    t.string   "title",      null: false
    t.string   "body"
    t.string   "url",        null: false
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "links", ["user_id"], name: "index_links_on_user_id", using: :btree

  create_table "subs", force: true do |t|
    t.string   "name",         null: false
    t.integer  "moderator_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "subs", ["moderator_id"], name: "index_subs_on_moderator_id", using: :btree
  add_index "subs", ["name"], name: "index_subs_on_name", unique: true, using: :btree

  create_table "users", force: true do |t|
    t.string   "username",        null: false
    t.string   "email"
    t.string   "password_digest", null: false
    t.string   "session_token",   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

end
