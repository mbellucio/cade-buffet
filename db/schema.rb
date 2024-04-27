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

ActiveRecord::Schema[7.1].define(version: 2024_04_27_165051) do
  create_table "buffets", force: :cascade do |t|
    t.string "company_name"
    t.string "phone_number"
    t.string "zip_code"
    t.string "adress"
    t.string "neighborhood"
    t.string "city"
    t.string "state_code"
    t.string "description"
    t.integer "company_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email"
    t.string "payment_method"
    t.index ["company_id"], name: "index_buffets_on_company_id", unique: true
  end

  create_table "clients", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "full_name"
    t.string "social_security_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_clients_on_email", unique: true
    t.index ["reset_password_token"], name: "index_clients_on_reset_password_token", unique: true
  end

  create_table "companies", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "buffet_name"
    t.string "company_registration_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_companies_on_email", unique: true
    t.index ["reset_password_token"], name: "index_companies_on_reset_password_token", unique: true
  end

  create_table "event_pricings", force: :cascade do |t|
    t.integer "pricing_id", null: false
    t.integer "event_id", null: false
    t.integer "base_price"
    t.integer "extra_person_fee"
    t.integer "extra_hour_fee"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_event_pricings_on_event_id"
    t.index ["pricing_id"], name: "index_event_pricings_on_pricing_id"
  end

  create_table "events", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.integer "min_quorum"
    t.integer "max_quorum"
    t.integer "standard_duration"
    t.string "menu"
    t.boolean "serve_alcohol"
    t.boolean "handle_decoration"
    t.boolean "valet_service"
    t.boolean "flexible_location"
    t.integer "buffet_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["buffet_id"], name: "index_events_on_buffet_id"
  end

  create_table "pricings", force: :cascade do |t|
    t.string "category"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "buffets", "companies"
  add_foreign_key "event_pricings", "events"
  add_foreign_key "event_pricings", "pricings"
  add_foreign_key "events", "buffets"
end
