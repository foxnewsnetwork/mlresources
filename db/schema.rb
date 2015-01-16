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

ActiveRecord::Schema.define(version: 20150115173747) do

  create_table "admin_users", force: :cascade do |t|
    t.string   "email",                        limit: 255,   null: false
    t.string   "crypted_password",             limit: 255,   null: false
    t.string   "salt",                         limit: 255,   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_me_token",            limit: 255
    t.datetime "remember_me_token_expires_at"
    t.string   "user_rank",                    limit: 255
    t.string   "company_name",                 limit: 255
    t.string   "phone_number",                 limit: 255
    t.text     "about_me",                     limit: 65535
    t.string   "address",                      limit: 255
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["remember_me_token"], name: "index_admin_users_on_remember_me_token", using: :btree

  create_table "apiv1_attachments", force: :cascade do |t|
    t.integer  "attachable_id",         limit: 4
    t.string   "attachable_type",       limit: 255
    t.string   "document_file_name",    limit: 255
    t.string   "document_content_type", limit: 255
    t.integer  "document_file_size",    limit: 4
    t.datetime "document_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  add_index "apiv1_attachments", ["attachable_id", "attachable_type"], name: "index_apiv1_attachments_on_attachable_id_and_attachable_type", using: :btree

  create_table "apiv1_email_objects", force: :cascade do |t|
    t.integer  "email_id",     limit: 4
    t.string   "class_name",   limit: 255
    t.string   "permalink_id", limit: 255
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "apiv1_email_objects", ["email_id"], name: "index_apiv1_email_objects_on_email_id", using: :btree

  create_table "apiv1_email_requests", force: :cascade do |t|
    t.string   "to",           limit: 255, null: false
    t.string   "cc",           limit: 255
    t.string   "bcc",          limit: 255
    t.string   "subject",      limit: 255
    t.string   "status",       limit: 255
    t.string   "from",         limit: 255
    t.string   "mailer_class", limit: 255, null: false
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "apiv1_email_requests", ["to", "mailer_class"], name: "index_apiv1_email_requests_on_to_and_mailer_class", using: :btree

  create_table "apiv1_employees", force: :cascade do |t|
    t.string   "person_name",    limit: 255
    t.string   "employee_title", limit: 255
    t.string   "email",          limit: 255
    t.string   "phone_number",   limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "apiv1_geomark_requests", force: :cascade do |t|
    t.integer  "place_id",     limit: 4
    t.string   "place_type",   limit: 255
    t.string   "permalink",    limit: 255
    t.string   "slugstyle",    limit: 255
    t.datetime "attempted_at"
    t.datetime "failed_at"
    t.datetime "succeed_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "apiv1_geomarkers", force: :cascade do |t|
    t.integer  "place_id",   limit: 4
    t.string   "place_type", limit: 255
    t.string   "permalink",  limit: 255
    t.decimal  "longitude",              precision: 10
    t.decimal  "latitude",               precision: 10
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "apiv1_geomarkers", ["place_id", "place_type"], name: "index_apiv1_geomarkers_on_place_id_and_place_type", using: :btree

  create_table "apiv1_listings_taxons", force: :cascade do |t|
    t.integer  "listing_id",   limit: 4
    t.string   "listing_type", limit: 255
    t.integer  "taxon_id",     limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "apiv1_listings_taxons", ["listing_id", "listing_type"], name: "index_apiv1_listings_taxons_on_listing_id_and_listing_type", using: :btree
  add_index "apiv1_listings_taxons", ["taxon_id"], name: "index_apiv1_listings_taxons_on_taxon_id", using: :btree

  create_table "apiv1_messages", force: :cascade do |t|
    t.string   "from_company",    limit: 255
    t.string   "sender_email",    limit: 255
    t.string   "subject_text",    limit: 255
    t.text     "message",         limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "phone_number",    limit: 255
    t.string   "contact_person",  limit: 255
    t.string   "company_address", limit: 255
  end

  create_table "apiv1_offer_messages", force: :cascade do |t|
    t.integer  "product_id",      limit: 4
    t.string   "from_company",    limit: 255
    t.string   "sender_email",    limit: 255
    t.string   "subject_text",    limit: 255
    t.string   "phone_number",    limit: 255
    t.string   "contact_person",  limit: 255
    t.string   "company_address", limit: 255
    t.string   "status",          limit: 255
    t.text     "message",         limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
    t.datetime "rejected_at"
  end

  add_index "apiv1_offer_messages", ["product_id"], name: "index_apiv1_offer_messages_on_product_id", using: :btree

  create_table "apiv1_pictures", force: :cascade do |t|
    t.integer  "depictable_id",    limit: 4
    t.string   "depictable_type",  limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "pic_file_name",    limit: 255
    t.string   "pic_content_type", limit: 255
    t.integer  "pic_file_size",    limit: 4
    t.datetime "pic_updated_at"
    t.datetime "deleted_at"
  end

  add_index "apiv1_pictures", ["depictable_id", "depictable_type"], name: "index_apiv1_pictures_on_depictable_id_and_depictable_type", using: :btree

  create_table "apiv1_products", force: :cascade do |t|
    t.string   "permalink",      limit: 255
    t.string   "sku",            limit: 255
    t.string   "material",       limit: 255
    t.string   "quality",        limit: 255
    t.string   "price",          limit: 255
    t.string   "amount",         limit: 255
    t.string   "place",          limit: 255
    t.text     "others",         limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "showcase_order", limit: 4
    t.datetime "deleted_at"
    t.datetime "finished_at"
  end

  add_index "apiv1_products", ["permalink"], name: "index_apiv1_products_on_permalink", using: :btree
  add_index "apiv1_products", ["sku"], name: "index_apiv1_products_on_sku", using: :btree

  create_table "apiv1_taxons", force: :cascade do |t|
    t.integer  "parent_id",      limit: 4
    t.string   "root_genus",     limit: 255, null: false
    t.string   "taxon_name",     limit: 255, null: false
    t.string   "permalink",      limit: 255, null: false
    t.string   "explanation",    limit: 255
    t.datetime "first_child_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "apiv1_taxons", ["parent_id"], name: "index_apiv1_taxons_on_parent_id", using: :btree
  add_index "apiv1_taxons", ["permalink", "root_genus"], name: "index_apiv1_taxons_on_permalink_and_root_genus", unique: true, using: :btree

  create_table "apiv1_translations", force: :cascade do |t|
    t.string   "locale",         limit: 255,                   null: false
    t.string   "key",            limit: 255,                   null: false
    t.text     "value",          limit: 65535
    t.text     "interpolations", limit: 65535
    t.boolean  "is_proc",        limit: 1,     default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "apiv1_translations", ["key", "locale"], name: "index_apiv1_translations_on_key_and_locale", unique: true, using: :btree

  create_table "apiv1_user_contacts", force: :cascade do |t|
    t.integer  "user_id",         limit: 4
    t.string   "name",            limit: 255
    t.string   "phone",           limit: 255
    t.string   "email",           limit: 255
    t.string   "address",         limit: 255
    t.datetime "made_primary_at"
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "apiv1_user_contacts", ["user_id"], name: "index_apiv1_user_contacts_on_user_id", using: :btree

  create_table "apiv1_users_product_relationships", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "product_id", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "apiv1_users_product_relationships", ["product_id"], name: "index_apiv1_users_product_relationships_on_product_id", using: :btree
  add_index "apiv1_users_product_relationships", ["user_id"], name: "index_apiv1_users_product_relationships_on_user_id", using: :btree

  create_table "commerce_units_dimensions", force: :cascade do |t|
    t.string   "root_dimension",    limit: 255,                                               null: false
    t.string   "unit_name",         limit: 255,                                               null: false
    t.string   "unitary_role",      limit: 255,                          default: "tertiary", null: false
    t.decimal  "multiply_constant",             precision: 17, scale: 5, default: 1.0,        null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
