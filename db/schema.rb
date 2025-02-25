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

ActiveRecord::Schema[7.1].define(version: 2025_02_21_171826) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "unaccent"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "advances", force: :cascade do |t|
    t.string "description", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "service_order_id", null: false
    t.index ["service_order_id"], name: "index_advances_on_service_order_id"
  end

  create_table "brands", force: :cascade do |t|
    t.string "name", null: false
    t.boolean "is_active", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_brands_on_name", unique: true
  end

  create_table "categories", force: :cascade do |t|
    t.string "name", null: false
    t.boolean "is_active", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "companies", force: :cascade do |t|
    t.string "name", null: false
    t.string "dni", null: false
    t.string "email", null: false
    t.integer "number_of_employees", default: 0, null: false
    t.string "payment_methods", default: [], null: false, array: true
    t.string "social_networks", default: [], null: false, array: true
    t.string "phone_numbers", default: [], null: false, array: true
    t.string "address", null: false
    t.boolean "is_active", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "location_id"
    t.index ["dni"], name: "unique_company_dni", unique: true
    t.index ["email"], name: "unique_company_email", unique: true
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

  create_table "notifications", force: :cascade do |t|
    t.string "category", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "advance_id"
    t.bigint "user_id"
    t.index ["advance_id"], name: "index_notifications_on_advance_id"
    t.index ["user_id"], name: "index_notifications_on_user_id"
  end

  create_table "notifications_receipts", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "notification_id"
    t.bigint "user_id"
    t.index ["notification_id"], name: "index_notifications_receipts_on_notification_id"
    t.index ["user_id"], name: "index_notifications_receipts_on_user_id"
  end

  create_table "orders", force: :cascade do |t|
    t.string "status", null: false
    t.decimal "vehicle_mileage", precision: 10, scale: 2, null: false
    t.boolean "is_active", default: true, null: false
    t.boolean "is_checked", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "vehicle_id", null: false
    t.bigint "company_id"
    t.bigint "created_by_id"
    t.bigint "assigned_to_id"
    t.index ["assigned_to_id"], name: "index_orders_on_assigned_to_id"
    t.index ["company_id"], name: "index_orders_on_company_id"
    t.index ["created_by_id"], name: "index_orders_on_created_by_id"
    t.index ["vehicle_id"], name: "index_orders_on_vehicle_id"
  end

  create_table "services", force: :cascade do |t|
    t.string "name", null: false
    t.string "description", null: false
    t.decimal "price_for_motorbike", precision: 10, scale: 2
    t.decimal "price_for_car", precision: 10, scale: 2
    t.decimal "price_for_van", precision: 10, scale: 2
    t.decimal "price_for_truck", precision: 10, scale: 2
    t.boolean "is_active", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "category_id"
    t.bigint "company_id"
    t.index ["category_id"], name: "index_services_on_category_id"
    t.index ["company_id"], name: "index_services_on_company_id"
  end

  create_table "services_orders", force: :cascade do |t|
    t.decimal "cost", precision: 10, scale: 2, null: false
    t.string "status", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "order_id", null: false
    t.bigint "service_id", null: false
    t.index ["order_id"], name: "index_services_orders_on_order_id"
    t.index ["service_id"], name: "index_services_orders_on_service_id"
  end

  create_table "user_order_reviews", force: :cascade do |t|
    t.string "message"
    t.integer "rating", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "order_id"
    t.index ["order_id"], name: "index_user_order_reviews_on_order_id"
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
    t.string "phone_number"
    t.boolean "is_active", default: true, null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "location_id", null: false
    t.index ["dni"], name: "unique_user_dni", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["email"], name: "unique_user_email", unique: true
    t.index ["location_id"], name: "index_users_on_location_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "users_companies", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "company_id", null: false
    t.string "roles", array: true
    t.boolean "is_active", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_users_companies_on_company_id"
    t.index ["user_id", "company_id"], name: "index_users_companies_on_user_id_and_company_id", unique: true
    t.index ["user_id"], name: "index_users_companies_on_user_id"
  end

  create_table "users_companies_requests", force: :cascade do |t|
    t.string "status", default: "pending", null: false
    t.string "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_company_id", null: false
    t.bigint "responder_user_id"
    t.index ["responder_user_id"], name: "index_users_companies_requests_on_responder_user_id"
    t.index ["user_company_id"], name: "index_users_companies_requests_on_user_company_id"
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

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "advances", "services_orders", column: "service_order_id"
  add_foreign_key "companies", "locations"
  add_foreign_key "locations", "locations", column: "parent_location_id"
  add_foreign_key "models", "brands"
  add_foreign_key "notifications", "advances"
  add_foreign_key "notifications", "users"
  add_foreign_key "notifications_receipts", "notifications"
  add_foreign_key "notifications_receipts", "users"
  add_foreign_key "orders", "companies"
  add_foreign_key "orders", "users_companies", column: "assigned_to_id"
  add_foreign_key "orders", "users_companies", column: "created_by_id"
  add_foreign_key "orders", "vehicles", on_delete: :nullify
  add_foreign_key "services", "categories"
  add_foreign_key "services", "companies"
  add_foreign_key "services_orders", "orders"
  add_foreign_key "services_orders", "services"
  add_foreign_key "user_order_reviews", "orders"
  add_foreign_key "users", "locations"
  add_foreign_key "users_companies", "companies"
  add_foreign_key "users_companies", "users"
  add_foreign_key "users_companies_requests", "users", column: "responder_user_id"
  add_foreign_key "users_companies_requests", "users_companies", column: "user_company_id"
  add_foreign_key "vehicles", "models"
  add_foreign_key "vehicles", "users"
end
