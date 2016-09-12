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

ActiveRecord::Schema.define(version: 20160912141621) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "addresses", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string   "salutation"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "company"
    t.string   "street"
    t.string   "house_no_main"
    t.string   "house_no_add"
    t.string   "other"
    t.uuid     "postal_code_id"
    t.string   "postal_code"
    t.uuid     "city_id"
    t.string   "city"
    t.uuid     "province_id"
    t.string   "province"
    t.uuid     "country_id"
    t.string   "country_code"
    t.string   "country"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.uuid     "trip_id"
    t.index ["trip_id"], name: "index_addresses_on_trip_id", using: :btree
  end

  create_table "drivers", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "phone_no"
    t.uuid     "plant_id"
    t.boolean  "enabled",    default: true
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.uuid     "user_id"
  end

  create_table "plants", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string   "company"
    t.text     "email"
    t.text     "phone_no"
    t.text     "address"
    t.uuid     "tenant_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "schedules", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.date     "date"
    t.uuid     "shift_id"
    t.uuid     "driver_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "shifts", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string   "name"
    t.boolean  "enabled",                default: false
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.time     "start_time"
    t.time     "end_time"
    t.time     "send_time"
    t.uuid     "plant_id"
    t.bit      "availability", limit: 8
  end

  create_table "shifts_time_windows", id: false, force: :cascade do |t|
    t.uuid "shift_id"
    t.uuid "time_window_id"
    t.index ["shift_id"], name: "index_shifts_time_windows_on_shift_id", using: :btree
    t.index ["time_window_id"], name: "index_shifts_time_windows_on_time_window_id", using: :btree
  end

  create_table "time_windows", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string   "label"
    t.uuid     "tenant_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.time     "start_time"
    t.time     "end_time"
  end

  create_table "trip_kinds", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "trips", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid     "trip_kind_id"
    t.uuid     "order_id"
    t.date     "date"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.time     "start_time"
    t.time     "end_time"
  end

  add_foreign_key "addresses", "trips"
end
