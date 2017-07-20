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

ActiveRecord::Schema.define(version: 20170720035900) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "applications", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "organization_id"
    t.string "aasm_state"
    t.text "detail"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["organization_id"], name: "index_applications_on_organization_id"
    t.index ["user_id"], name: "index_applications_on_user_id"
  end

  create_table "organizations", force: :cascade do |t|
    t.string "name"
    t.string "website"
    t.string "phone"
    t.string "address"
    t.float "longitude"
    t.float "latitude"
    t.text "additional"
    t.string "picture"
    t.string "aasm_state"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_organizations_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.date "dob"
    t.string "username"
    t.string "picture"
    t.text "bio"
    t.boolean "is_admin", default: true
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "applications", "organizations"
  add_foreign_key "applications", "users"
  add_foreign_key "organizations", "users"
end
