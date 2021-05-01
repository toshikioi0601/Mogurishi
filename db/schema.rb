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

ActiveRecord::Schema.define(version: 2021_05_01_052626) do

  create_table "comments", force: :cascade do |t|
    t.integer "divelog_id"
    t.integer "user_id"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["divelog_id"], name: "index_comments_on_divelog_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "divelogs", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.float "depth"
    t.float "water_temp"
    t.float "temp"
    t.text "weather"
    t.float "visibility"
    t.text "reference"
    t.integer "popularity"
    t.text "dive_memo"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "picture"
    t.index ["user_id", "created_at"], name: "index_divelogs_on_user_id_and_created_at"
    t.index ["user_id"], name: "index_divelogs_on_user_id"
  end

  create_table "favorites", force: :cascade do |t|
    t.integer "user_id"
    t.integer "divelog_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "divelog_id"], name: "index_favorites_on_user_id_and_divelog_id", unique: true
  end

  create_table "logs", force: :cascade do |t|
    t.integer "divelog_id"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["divelog_id"], name: "index_logs_on_divelog_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.integer "user_id"
    t.integer "divelog_id"
    t.integer "variety"
    t.text "content"
    t.integer "from_user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_notifications_on_user_id"
  end

  create_table "relationships", force: :cascade do |t|
    t.integer "follower_id"
    t.integer "followed_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["followed_id"], name: "index_relationships_on_followed_id"
    t.index ["follower_id", "followed_id"], name: "index_relationships_on_follower_id_and_followed_id", unique: true
    t.index ["follower_id"], name: "index_relationships_on_follower_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.integer "divelog_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.text "introduction"
    t.string "sex"
    t.integer "experience"
    t.string "license"
    t.string "organization"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.string "remember_digest"
    t.boolean "admin", default: false
    t.boolean "notification", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end
