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

ActiveRecord::Schema[7.0].define(version: 2023_05_08_071320) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

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

  create_table "agents", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "phone"
    t.boolean "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "customers", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "contact"
    t.string "father_name"
    t.string "mother_name"
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
    t.string "status"
    t.date "due_at"
    t.date "paid_at"
    t.float "amount"
    t.bigint "loan_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "penalty_amount", default: 0.0
    t.float "paid_amount", default: 0.0
    t.float "due_amount", default: 0.0
    t.boolean "penalty", default: false
    t.index ["loan_id"], name: "index_emis_on_loan_id"
  end

  create_table "guarentors", force: :cascade do |t|
    t.string "email"
    t.string "contact"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.bigint "loan_id"
    t.index ["loan_id"], name: "index_guarentors_on_loan_id"
  end

  create_table "investor_transactions", force: :cascade do |t|
    t.float "amount_added"
    t.float "amount_withdrawal"
    t.bigint "investor_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["investor_id"], name: "index_investor_transactions_on_investor_id"
  end

  create_table "investors", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "contact_no"
    t.float "profit_amount"
    t.float "total_amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status"
  end

  create_table "loans", force: :cascade do |t|
    t.float "amount"
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
    t.integer "total_duration"
    t.bigint "agent_id"
    t.index ["agent_id"], name: "index_loans_on_agent_id"
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

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "emis", "loans"
  add_foreign_key "guarentors", "loans"
  add_foreign_key "investor_transactions", "investors"
  add_foreign_key "loans", "agents"
  add_foreign_key "loans", "customers"
end
