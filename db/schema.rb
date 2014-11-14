# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20141114000255) do

  create_table "admin_users", force: true do |t|
    t.string   "email",                        null: false
    t.string   "crypted_password",             null: false
    t.string   "salt",                         null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_me_token"
    t.datetime "remember_me_token_expires_at"
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["remember_me_token"], name: "index_admin_users_on_remember_me_token", using: :btree

  create_table "apiv1_attachments", force: true do |t|
    t.integer  "attachable_id"
    t.string   "attachable_type"
    t.string   "document_file_name"
    t.string   "document_content_type"
    t.integer  "document_file_size"
    t.datetime "document_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "apiv1_attachments", ["attachable_id", "attachable_type"], name: "index_apiv1_attachments_on_attachable_id_and_attachable_type", using: :btree

  create_table "apiv1_employees", force: true do |t|
    t.string   "person_name"
    t.string   "employee_title"
    t.string   "email"
    t.string   "phone_number"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "apiv1_listings_taxons", force: true do |t|
    t.integer  "listing_id"
    t.string   "listing_type"
    t.integer  "taxon_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "apiv1_listings_taxons", ["listing_id", "listing_type"], name: "index_apiv1_listings_taxons_on_listing_id_and_listing_type", using: :btree
  add_index "apiv1_listings_taxons", ["taxon_id"], name: "index_apiv1_listings_taxons_on_taxon_id", using: :btree

  create_table "apiv1_messages", force: true do |t|
    t.string   "from_company"
    t.string   "sender_email"
    t.string   "subject_text"
    t.text     "message"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "phone_number"
    t.string   "contact_person"
    t.string   "company_address"
  end

  create_table "apiv1_pictures", force: true do |t|
    t.integer  "depictable_id"
    t.string   "depictable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "pic_file_name"
    t.string   "pic_content_type"
    t.integer  "pic_file_size"
    t.datetime "pic_updated_at"
  end

  add_index "apiv1_pictures", ["depictable_id", "depictable_type"], name: "index_apiv1_pictures_on_depictable_id_and_depictable_type", using: :btree

  create_table "apiv1_products", force: true do |t|
    t.string   "permalink"
    t.string   "sku"
    t.string   "material"
    t.string   "quality"
    t.string   "price"
    t.string   "amount"
    t.string   "place"
    t.text     "others"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "showcase_order"
  end

  add_index "apiv1_products", ["permalink"], name: "index_apiv1_products_on_permalink", using: :btree
  add_index "apiv1_products", ["sku"], name: "index_apiv1_products_on_sku", using: :btree

  create_table "apiv1_taxons", force: true do |t|
    t.integer  "parent_id"
    t.string   "root_genus",     null: false
    t.string   "taxon_name",     null: false
    t.string   "permalink",      null: false
    t.string   "explanation"
    t.datetime "first_child_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "apiv1_taxons", ["parent_id"], name: "index_apiv1_taxons_on_parent_id", using: :btree
  add_index "apiv1_taxons", ["permalink", "root_genus"], name: "index_apiv1_taxons_on_permalink_and_root_genus", unique: true, using: :btree

  create_table "apiv1_translations", force: true do |t|
    t.string   "locale",                         null: false
    t.string   "key",                            null: false
    t.text     "value"
    t.text     "interpolations"
    t.boolean  "is_proc",        default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "apiv1_translations", ["key", "locale"], name: "index_apiv1_translations_on_key_and_locale", unique: true, using: :btree

  create_table "commerce_units_dimensions", force: true do |t|
    t.string   "root_dimension",                                                  null: false
    t.string   "unit_name",                                                       null: false
    t.string   "unitary_role",                               default: "tertiary", null: false
    t.decimal  "multiply_constant", precision: 17, scale: 5, default: 1.0,        null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
