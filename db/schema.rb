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

ActiveRecord::Schema[7.1].define(version: 2024_09_03_154433) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "brands", force: :cascade do |t|
    t.string "name", null: false
    t.boolean "is_active", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_brands_on_name", unique: true
  end

  create_table "companies", force: :cascade do |t|
    t.string "name", null: false
    t.string "dni", null: false
    t.string "company_charter", null: false
    t.string "email", null: false
    t.integer "number_of_employees", default: 1, null: false
    t.string "payment_methods", default: [], null: false, array: true
    t.string "social_networks", default: [], null: false, array: true
    t.string "phonenumbers", default: [], null: false, array: true
    t.string "address", null: false
    t.string "request_status", default: "pending", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "location_id"
    t.index ["location_id"], name: "index_companies_on_location_id"
  end

  create_table "jwt_denylist", force: :cascade do |t|
    t.string "jti", null: false
    t.datetime "exp", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["jti"], name: "index_jwt_denylist_on_jti"
    t.index ["jti"], name: "unique_jti", unique: true
  end

  create_table "locations", force: :cascade do |t|
    t.string "name", null: false
    t.string "location_type", null: false
    t.boolean "is_active", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "parent_location_id"
    t.index ["parent_location_id"], name: "index_locations_on_parent_location_id"
  end

  create_table "models", force: :cascade do |t|
    t.string "name", null: false
    t.boolean "is_active", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "brand_id"
    t.index ["brand_id"], name: "index_models_on_brand_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "dni", null: false
    t.string "gender", null: false
    t.date "birthdate", null: false
    t.string "address"
    t.string "phonenumber"
    t.string "roles", default: ["general"], array: true
    t.boolean "is_active", default: true, null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "company_id"
    t.index ["company_id"], name: "index_users_on_company_id"
    t.index ["dni"], name: "unique_user_dni", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["email"], name: "unique_user_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "vehicles", force: :cascade do |t|
    t.integer "year", null: false
    t.integer "axles", null: false
    t.integer "tires", null: false
    t.string "color", default: "", null: false
    t.string "vehicle_type", default: "", null: false
    t.integer "load_capacity", default: 0, null: false
    t.bigint "mileage", default: 1, null: false
    t.string "engine_serial", default: "", null: false
    t.string "body_serial", default: "", null: false
    t.string "license_plate", default: "", null: false
    t.string "engine_type", default: "", null: false
    t.string "transmission", default: "", null: false
    t.boolean "is_active", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "model_id"
    t.bigint "user_id"
    t.index ["body_serial"], name: "unique_body_serial", unique: true
    t.index ["engine_serial"], name: "unique_engine_serial", unique: true
    t.index ["license_plate"], name: "unique_license_plate", unique: true
    t.index ["model_id"], name: "index_vehicles_on_model_id"
    t.index ["user_id"], name: "index_vehicles_on_user_id"
  end

  add_foreign_key "companies", "locations"
  add_foreign_key "locations", "locations", column: "parent_location_id"
  add_foreign_key "models", "brands"
  add_foreign_key "users", "companies"
  add_foreign_key "vehicles", "models"
  add_foreign_key "vehicles", "users"
end
