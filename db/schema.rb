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

ActiveRecord::Schema[7.0].define(version: 2023_06_21_144647) do
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

  create_table "etudiants", force: :cascade do |t|
    t.string "matricule"
    t.string "first_name"
    t.string "last_name"
    t.integer "gender"
    t.datetime "birth_date"
    t.string "birth_place"
    t.string "nationality"
    t.integer "marital_status"
    t.string "email"
    t.string "address"
    t.string "parent_address"
    t.bigint "user_id"
    t.string "certificat_name"
    t.integer "certificat_year"
    t.string "certificat_place"
    t.string "certificat_country"
    t.bigint "field_id"
    t.bigint "field_option_id"
    t.jsonb "metadata"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "field_options", force: :cascade do |t|
    t.string "name"
    t.bigint "field_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["field_id"], name: "index_field_options_on_field_id"
  end

  create_table "fields", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "import_students", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "school_years", force: :cascade do |t|
    t.string "name"
    t.boolean "current_year"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "statistics", force: :cascade do |t|
    t.float "sold"
    t.float "collected_amount"
    t.float "pending_payout"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "student_school_years", force: :cascade do |t|
    t.bigint "student_id"
    t.bigint "school_year_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["student_id"], name: "index_student_school_years_on_student_id"
  end

  create_table "students", force: :cascade do |t|
    t.string "matricule"
    t.string "first_name"
    t.string "last_name"
    t.integer "gender"
    t.datetime "birth_date"
    t.string "birth_place"
    t.string "nationality"
    t.integer "marital_status"
    t.string "email"
    t.string "address"
    t.string "parent_address"
    t.bigint "user_id"
    t.string "certificat_name"
    t.integer "certificat_year"
    t.string "certificat_place"
    t.string "certificat_country"
    t.bigint "field_id"
    t.bigint "field_option_id"
    t.jsonb "metadata"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "field_one_id"
    t.bigint "field_two_id"
    t.bigint "field_three_id"
    t.bigint "field_option_one_id"
    t.bigint "field_option_two_id"
    t.bigint "field_option_three_id"
    t.index ["field_one_id"], name: "index_students_on_field_one_id"
    t.index ["field_option_one_id"], name: "index_students_on_field_option_one_id"
    t.index ["field_option_three_id"], name: "index_students_on_field_option_three_id"
    t.index ["field_option_two_id"], name: "index_students_on_field_option_two_id"
    t.index ["field_three_id"], name: "index_students_on_field_three_id"
    t.index ["field_two_id"], name: "index_students_on_field_two_id"
  end

  create_table "transactions", force: :cascade do |t|
    t.float "amount"
    t.integer "payment_method"
    t.string "reference"
    t.bigint "student_id"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["student_id"], name: "index_transactions_on_student_id"
  end

  create_table "universities", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "first_name", default: "", null: false
    t.string "last_name", default: "", null: false
    t.string "phone", default: "", null: false
    t.integer "profile", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_admin", default: false
    t.bigint "university_id"
    t.string "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer "invitation_limit"
    t.string "invited_by_type"
    t.bigint "invited_by_id"
    t.integer "invitations_count", default: 0
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["invitation_token"], name: "index_users_on_invitation_token", unique: true
    t.index ["invited_by_id"], name: "index_users_on_invited_by_id"
    t.index ["invited_by_type", "invited_by_id"], name: "index_users_on_invited_by"
    t.index ["phone"], name: "index_users_on_phone", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["university_id"], name: "index_users_on_university_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "field_options", "fields"
  add_foreign_key "student_school_years", "students"
  add_foreign_key "transactions", "students"
end
