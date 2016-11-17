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

ActiveRecord::Schema.define(version: 20161115150024) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "exchanges", force: :cascade do |t|
    t.string   "service",    limit: 30
    t.string   "from",       limit: 3
    t.string   "to",         limit: 3
    t.decimal  "rate",                  precision: 24, scale: 12
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
  end

  add_index "exchanges", ["from", "to"], name: "index_exchanges_on_from_and_to", using: :btree

  create_table "plans", force: :cascade do |t|
    t.decimal  "monthly_price",            precision: 24, scale: 6
    t.decimal  "annually_price",           precision: 24, scale: 6
    t.string   "currency",       limit: 3
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
  end

  create_table "posts", force: :cascade do |t|
    t.integer "user_id"
  end

  create_table "products", force: :cascade do |t|
    t.decimal  "price",                    precision: 24, scale: 6
    t.string   "price_currency", limit: 3
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
  end

  create_table "users", force: :cascade do |t|
    t.string  "username"
    t.string  "name"
    t.string  "email"
    t.integer "age"
    t.integer "phone"
  end

end
