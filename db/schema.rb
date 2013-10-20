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

ActiveRecord::Schema.define(version: 20131020043550) do

  create_table "goodies", force: true do |t|
    t.string   "name",                                 null: false
    t.text     "description",                          null: false
    t.decimal  "price",       precision: 10, scale: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "orders", force: true do |t|
    t.integer  "user_id",      null: false
    t.integer  "goodie_id",    null: false
    t.text     "destination",  null: false
    t.string   "charge_token", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "orders", ["goodie_id"], name: "index_orders_on_goodie_id", using: :btree
  add_index "orders", ["user_id"], name: "index_orders_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "realname",       null: false
    t.string   "username",       null: false
    t.binary   "password",       null: false
    t.string   "email",          null: false
    t.string   "customer_token"
    t.string   "twitter_id"
    t.string   "facebook_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end