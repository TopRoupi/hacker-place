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

ActiveRecord::Schema[7.1].define(version: 2024_06_09_142932) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "computers", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "lgo_processes", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "v_process_id", null: false
    t.string "pid", null: false
    t.string "tcp_port"
    t.string "job_id"
    t.string "job_server_ip"
    t.integer "state", default: 0, null: false
    t.date "started_at"
    t.date "ended_at"
    t.date "waited_at"
    t.string "code", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["v_process_id"], name: "index_lgo_processes_on_v_process_id"
  end

  create_table "players", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "email", null: false
    t.string "password_digest", null: false
    t.boolean "verified", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "computer_id"
    t.index ["computer_id"], name: "index_players_on_computer_id"
    t.index ["email"], name: "index_players_on_email", unique: true
  end

  create_table "sessions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "player_id", null: false
    t.string "user_agent"
    t.string "ip_address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["player_id"], name: "index_sessions_on_player_id"
  end

  create_table "v_files", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "computer_id", null: false
    t.string "name"
    t.string "content"
    t.string "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["computer_id"], name: "index_v_files_on_computer_id"
    t.index ["name", "computer_id"], name: "index_v_files_on_name_and_computer_id", unique: true
  end

  create_table "v_processes", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "computer_id", null: false
    t.string "name"
    t.integer "cpu_usage", default: 0, null: false
    t.integer "ram_usage", default: 0, null: false
    t.integer "state", default: 0, null: false
    t.date "started_at", null: false
    t.date "ended_at"
    t.string "pid", null: false
    t.string "command", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["computer_id"], name: "index_v_processes_on_computer_id"
  end

  add_foreign_key "lgo_processes", "v_processes"
  add_foreign_key "sessions", "players"
  add_foreign_key "v_processes", "computers"
end
