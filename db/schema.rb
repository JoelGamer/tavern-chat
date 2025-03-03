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

ActiveRecord::Schema[8.0].define(version: 2025_02_28_052155) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

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

  create_table "application_accounts", force: :cascade do |t|
    t.string "username", null: false
    t.string "token_digest", null: false
    t.string "display_name", null: false
    t.string "status"
    t.string "visibility", null: false
    t.string "saved_visibility"
    t.string "biography"
    t.string "confirmation_token"
    t.datetime "confirmation_sent_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["username"], name: "index_application_accounts_on_username", unique: true
  end

  create_table "tavern_accounts", force: :cascade do |t|
    t.bigint "tavern_id", null: false
    t.string "account_type", null: false
    t.bigint "account_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_type", "account_id"], name: "index_tavern_accounts_on_account"
    t.index ["tavern_id"], name: "index_tavern_accounts_on_tavern_id"
  end

  create_table "tavern_table_messages", force: :cascade do |t|
    t.string "content"
    t.bigint "tavern_table_id", null: false
    t.string "account_type", null: false
    t.bigint "account_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_type", "account_id"], name: "index_tavern_table_messages_on_account"
    t.index ["tavern_table_id"], name: "index_tavern_table_messages_on_tavern_table_id"
  end

  create_table "tavern_tables", force: :cascade do |t|
    t.integer "variant", default: 0, null: false
    t.string "name", null: false
    t.boolean "explicit_content", default: false, null: false
    t.bigint "tavern_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tavern_id"], name: "index_tavern_tables_on_tavern_id"
  end

  create_table "taverns", force: :cascade do |t|
    t.string "name", null: false
    t.string "slug"
    t.bigint "creator_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["creator_id"], name: "index_taverns_on_creator_id"
  end

  create_table "user_account_friends", force: :cascade do |t|
    t.string "status", null: false
    t.bigint "user_account_requester_id", null: false
    t.bigint "user_account_receiver_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_account_receiver_id"], name: "index_user_account_friends_on_user_account_receiver_id"
    t.index ["user_account_requester_id"], name: "index_user_account_friends_on_user_account_requester_id"
  end

  create_table "user_accounts", force: :cascade do |t|
    t.string "username", null: false
    t.string "email", null: false
    t.string "password_digest", null: false
    t.string "display_name", null: false
    t.string "phone_number"
    t.string "status"
    t.string "visibility", null: false
    t.string "saved_visibility"
    t.string "biography"
    t.string "confirmation_token"
    t.datetime "confirmation_sent_at"
    t.datetime "confirmation_at"
    t.string "phone_number_confirmation_token"
    t.datetime "phone_number_confirmation_sent_at"
    t.datetime "phone_number_confirmation_at"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_user_accounts_on_email", unique: true
    t.index ["username"], name: "index_user_accounts_on_username", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "tavern_accounts", "taverns"
  add_foreign_key "tavern_table_messages", "tavern_tables"
  add_foreign_key "tavern_tables", "taverns"
  add_foreign_key "taverns", "user_accounts", column: "creator_id"
  add_foreign_key "user_account_friends", "user_accounts", column: "user_account_receiver_id"
  add_foreign_key "user_account_friends", "user_accounts", column: "user_account_requester_id"
end
