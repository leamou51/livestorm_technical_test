# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_09_22_114458) do

  create_table "adventurers", force: :cascade do |t|
    t.string "name"
    t.integer "strength"
    t.integer "sagacity"
    t.integer "luck"
    t.integer "trickery"
    t.string "attacks"
    t.string "shields"
    t.string "quote"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "enemies", force: :cascade do |t|
    t.string "name"
    t.integer "level"
    t.integer "health_point", default: 5
    t.boolean "boss", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rooms", force: :cascade do |t|
    t.string "name"
    t.boolean "item"
    t.integer "enemy_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["enemy_id"], name: "index_rooms_on_enemy_id"
  end

  create_table "rounds", force: :cascade do |t|
    t.integer "user_id"
    t.integer "room_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["room_id"], name: "index_rounds_on_room_id"
    t.index ["user_id"], name: "index_rounds_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.integer "score", default: 0
    t.integer "health_point", default: 5
    t.integer "adventurer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["adventurer_id"], name: "index_users_on_adventurer_id"
  end

  add_foreign_key "rooms", "enemies"
  add_foreign_key "rounds", "rooms"
  add_foreign_key "rounds", "users"
  add_foreign_key "users", "adventurers"
end
