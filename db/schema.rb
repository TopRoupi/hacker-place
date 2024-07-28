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

ActiveRecord::Schema[7.1].define(version: 2024_07_21_193546) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "hard_drive_hardwares", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "hard_drive_id", null: false
    t.uuid "mother_board_hardware_id", null: false
    t.boolean "bootable", null: false
    t.jsonb "path_mount_table"
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["hard_drive_id"], name: "index_hard_drive_hardwares_on_hard_drive_id"
    t.index ["mother_board_hardware_id"], name: "index_hard_drive_hardwares_on_mother_board_hardware_id"
  end

  create_table "hard_drives", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.integer "capacity_megabytes", null: false
    t.integer "read_speed_megabytes", null: false
    t.integer "write_speed_megabytes", null: false
    t.float "durability_loss", null: false
    t.integer "socket_type", null: false
    t.string "product_model_name", null: false
    t.string "product_model_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "lgo_processes", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "v_process_id", null: false
    t.string "pid"
    t.string "tcp_port"
    t.string "job_id"
    t.string "job_server_ip"
    t.integer "state", default: 0, null: false
    t.date "started_at"
    t.date "ended_at"
    t.date "slept_at"
    t.string "code", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["v_process_id"], name: "index_lgo_processes_on_v_process_id"
  end

  create_table "machines", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "mother_board_hardwares", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "machine_id", null: false
    t.uuid "mother_board_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["machine_id"], name: "index_mother_board_hardwares_on_machine_id"
    t.index ["mother_board_id"], name: "index_mother_board_hardwares_on_mother_board_id"
  end

  create_table "mother_boards", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.jsonb "config", null: false
    t.float "durability_loss", null: false
    t.string "product_model_name", null: false
    t.string "product_model_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "partitions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "hard_drive_hardware_id", null: false
    t.integer "size_megabytes", null: false
    t.integer "start_position", null: false
    t.integer "type", null: false
    t.boolean "bootable", null: false
    t.string "encryption_password"
    t.boolean "password"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["hard_drive_hardware_id"], name: "index_partitions_on_hard_drive_hardware_id"
  end

  create_table "players", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "email", null: false
    t.string "password_digest", null: false
    t.boolean "verified", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "machine_id"
    t.index ["email"], name: "index_players_on_email", unique: true
    t.index ["machine_id"], name: "index_players_on_machine_id"
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
    t.uuid "machine_id", null: false
    t.string "name"
    t.string "content"
    t.string "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["machine_id"], name: "index_v_files_on_machine_id"
    t.index ["name", "machine_id"], name: "index_v_files_on_name_and_machine_id", unique: true
  end

  create_table "v_processes", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "machine_id", null: false
    t.string "name"
    t.integer "cpu_usage", default: 0, null: false
    t.integer "ram_usage", default: 0, null: false
    t.integer "state", default: 0, null: false
    t.date "started_at"
    t.date "ended_at"
    t.string "pid", null: false
    t.string "command", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["machine_id"], name: "index_v_processes_on_machine_id"
  end

  add_foreign_key "hard_drive_hardwares", "hard_drives", column: "hard_drive_id"
  add_foreign_key "hard_drive_hardwares", "mother_board_hardwares"
  add_foreign_key "lgo_processes", "v_processes"
  add_foreign_key "mother_board_hardwares", "machines"
  add_foreign_key "mother_board_hardwares", "mother_boards"
  add_foreign_key "partitions", "hard_drive_hardwares"
  add_foreign_key "sessions", "players"
  add_foreign_key "v_processes", "machines"
end
