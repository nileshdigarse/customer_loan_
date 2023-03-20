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

ActiveRecord::Schema[7.0].define(version: 2023_03_20_101651) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.string "street"
    t.string "city"
    t.string "state"
    t.string "zipcode"
    t.string "addressable_type", null: false
    t.bigint "addressable_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["addressable_type", "addressable_id"], name: "index_addresses_on_addressable"
  end

  create_table "customers", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "contact"
  end

  create_table "documents", force: :cascade do |t|
    t.string "aadhar_card"
    t.string "pancard"
    t.string "documentable_type", null: false
    t.bigint "documentable_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["documentable_type", "documentable_id"], name: "index_documents_on_documentable"
  end

  create_table "emis", force: :cascade do |t|
    t.integer "month"
    t.float "principal"
    t.float "interest_amount"
    t.float "balance"
    t.float "penalty"
    t.string "status"
    t.date "due_at"
    t.date "paid_at"
    t.float "amount"
    t.bigint "loan_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["loan_id"], name: "index_emis_on_loan_id"
  end

  create_table "guarentors", force: :cascade do |t|
    t.string "email"
    t.string "contact"
    t.bigint "customer_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.index ["customer_id"], name: "index_guarentors_on_customer_id"
  end

  create_table "investors", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "contact_no"
    t.float "profit_amount"
    t.float "total_amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "loans", force: :cascade do |t|
    t.string "amount"
    t.integer "number_emis"
    t.integer "pending_emi"
    t.float "roi"
    t.string "status"
    t.bigint "customer_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "duration_year"
    t.integer "duration_month"
    t.float "penalty"
    t.date "started_at"
    t.float "total_payment"
    t.float "total_interest"
    t.float "recieved_amount"
    t.float "emi_amount"
    t.float "file_charge"
    t.string "loan_type"
    t.date "end_at"
    t.date "closed_at"
    t.index ["customer_id"], name: "index_loans_on_customer_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "emis", "loans"
  add_foreign_key "guarentors", "customers"
  add_foreign_key "loans", "customers"
end
