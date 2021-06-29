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

ActiveRecord::Schema.define(version: 2021_06_29_082420) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.bigint "client_id"
    t.string "first_line"
    t.string "second_line"
    t.string "third_line"
    t.string "town"
    t.string "post_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_addresses_on_client_id"
  end

  create_table "clients", force: :cascade do |t|
    t.string "name"
    t.string "nick_name"
    t.string "email_address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "extra_line"
  end

  create_table "invoice_items", force: :cascade do |t|
    t.bigint "service_id"
    t.decimal "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "invoice_id"
    t.index ["invoice_id"], name: "index_invoice_items_on_invoice_id"
    t.index ["service_id"], name: "index_invoice_items_on_service_id"
  end

  create_table "invoices", force: :cascade do |t|
    t.date "issue_date"
    t.bigint "client_id"
    t.date "due_date"
    t.binary "pdf"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "total"
    t.boolean "is_invoice_paid"
    t.index ["client_id"], name: "index_invoices_on_client_id"
  end

  create_table "services", force: :cascade do |t|
    t.string "description"
    t.decimal "price"
    t.boolean "is_active"
    t.boolean "is_visible"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "addresses", "clients"
  add_foreign_key "invoice_items", "invoices"
  add_foreign_key "invoice_items", "services"
  add_foreign_key "invoices", "clients"
end
