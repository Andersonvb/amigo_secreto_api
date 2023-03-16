# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_03_16_195022) do
  create_table "couples", force: :cascade do |t|
    t.integer "game_id", null: false
    t.integer "first_worker_id", null: false
    t.integer "second_worker_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["first_worker_id"], name: "index_couples_on_first_worker_id"
    t.index ["game_id"], name: "index_couples_on_game_id"
    t.index ["second_worker_id"], name: "index_couples_on_second_worker_id"
  end

  create_table "games", force: :cascade do |t|
    t.integer "year_game"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "locations", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "worker_without_a_pairs", force: :cascade do |t|
    t.integer "game_id", null: false
    t.integer "worker_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_worker_without_a_pairs_on_game_id"
    t.index ["worker_id"], name: "index_worker_without_a_pairs_on_worker_id"
  end

  create_table "workers", force: :cascade do |t|
    t.string "name"
    t.integer "location_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["location_id"], name: "index_workers_on_location_id"
  end

  add_foreign_key "couples", "games"
  add_foreign_key "couples", "workers", column: "first_worker_id"
  add_foreign_key "couples", "workers", column: "second_worker_id"
  add_foreign_key "worker_without_a_pairs", "games"
  add_foreign_key "worker_without_a_pairs", "workers"
  add_foreign_key "workers", "locations"
end
