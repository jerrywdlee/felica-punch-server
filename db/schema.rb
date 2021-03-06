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

ActiveRecord::Schema.define(version: 20180108174617) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string "email"
    t.string "pass"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cards", force: :cascade do |t|
    t.integer "user_id"
    t.string "card_uid"
    t.integer "card_type"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "devices", force: :cascade do |t|
    t.string "device_uid"
    t.text "description"
    t.string "param_1"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "punch_logs", force: :cascade do |t|
    t.string "card_uid"
    t.integer "card_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "pass"
    t.text "description"
    t.string "slack_url"
    t.string "slack_room_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slack_name"
    t.string "param_1"
    t.string "param_2"
    t.string "param_3"
  end

end
