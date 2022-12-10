# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_09_19_193140) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "inventory_item_classes", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "company_id", default: 1, null: false
    t.string "lot_format"
    t.boolean "product", default: false, null: false
  end

  create_table "inventory_item_locations", force: :cascade do |t|
    t.bigint "item_id", null: false
    t.bigint "location_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "company_id", default: 1, null: false
    t.index ["item_id"], name: "index_inventory_item_locations_on_item_id"
    t.index ["location_id"], name: "index_inventory_item_locations_on_location_id"
  end

  create_table "inventory_item_lots", force: :cascade do |t|
    t.bigint "item_id", null: false
    t.string "lot_code"
    t.date "expire_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "company_id", default: 1, null: false
    t.index ["item_id"], name: "index_inventory/item_lots_on_item_id"
  end

  create_table "inventory_items", force: :cascade do |t|
    t.string "code"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "item_class_id"
    t.bigint "base_unit_id"
    t.integer "company_id", default: 1, null: false
    t.index ["base_unit_id"], name: "index_items_on_base_unit_id"
    t.index ["item_class_id"], name: "index_items_on_item_class_id"
  end

  create_table "inventory_locations", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "company_id", default: 1, null: false
  end

  create_table "inventory_products", force: :cascade do |t|
    t.integer "item_id"
    t.string "code"
    t.string "name"
    t.integer "unit_qty"
    t.string "gtin_14"
    t.string "unit_upc"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.float "height"
    t.float "length"
    t.float "width"
    t.float "weight"
    t.integer "layer_qty"
    t.integer "pallet_layers"
    t.integer "company_id", default: 1, null: false
    t.bigint "channel_id"
    t.bigint "category_id"
    t.integer "dim_unit_id"
    t.integer "wt_unit_id"
    t.index ["category_id"], name: "index_inventory_products_on_category_id"
    t.index ["channel_id"], name: "index_inventory_products_on_channel_id"
  end

  create_table "inventory_receipt_items", id: :bigint, default: -> { "nextval('receipt_items_id_seq'::regclass)" }, force: :cascade do |t|
    t.bigint "receipt_id", null: false
    t.integer "number"
    t.string "description"
    t.float "qty"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "company_id", default: 1, null: false
    t.index ["receipt_id"], name: "index_receipt_items_on_receipt_id"
  end

  create_table "inventory_receipts", id: :bigint, default: -> { "nextval('receipts_id_seq'::regclass)" }, force: :cascade do |t|
    t.datetime "received_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "company_id", default: 1, null: false
  end

  create_table "inventory_shipment_items", force: :cascade do |t|
    t.integer "number"
    t.bigint "shipment_id", null: false
    t.string "description"
    t.float "qty"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "company_id", default: 1, null: false
    t.index ["shipment_id"], name: "index_shipment_items_on_shipment_id"
  end

  create_table "inventory_shipments", force: :cascade do |t|
    t.datetime "requested_ship_at"
    t.datetime "requested_pickup_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "company_id", default: 1, null: false
  end

  create_table "inventory_transaction_types", force: :cascade do |t|
    t.string "code"
    t.string "name"
    t.string "default_direction"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "company_id", default: 1, null: false
  end

  create_table "inventory_transactions", force: :cascade do |t|
    t.datetime "transaction_date"
    t.float "base_qty_increase", default: 0.0
    t.float "base_qty_decrease", default: 0.0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "item_lot_id"
    t.bigint "location_id"
    t.bigint "transaction_type_id"
    t.string "source_type"
    t.bigint "source_id"
    t.integer "company_id", default: 1, null: false
    t.integer "item_id"
    t.index ["item_lot_id"], name: "index_transactions_on_item_lot_id"
    t.index ["location_id"], name: "index_transactions_on_location_id"
    t.index ["source_type", "source_id"], name: "index_transactions_on_source_type_and_source_id"
    t.index ["transaction_type_id"], name: "index_transactions_on_transaction_type_id"
  end

  create_table "purchases_order_lines", force: :cascade do |t|
    t.bigint "order_id"
    t.integer "number"
    t.string "description"
    t.float "qty"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "company_id", default: 1, null: false
    t.index ["order_id"], name: "order_id_index"
  end

  create_table "purchases_orders", force: :cascade do |t|
    t.integer "po_number"
    t.datetime "order_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "ship_date"
    t.string "pickup_date"
    t.integer "vendor_account_id"
    t.integer "company_id", default: 1, null: false
    t.integer "bill_to_address_id"
    t.integer "ship_from_address_id"
    t.integer "ship_to_address_id"
  end

  create_table "purchases_vendors", force: :cascade do |t|
    t.string "code"
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "company_id", default: 1, null: false
  end

  create_table "sales_categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "company_id"
    t.index ["company_id"], name: "index_sales_categories_on_company_id"
  end

  create_table "sales_channels", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "company_id"
    t.index ["company_id"], name: "index_sales_channels_on_company_id"
  end

  create_table "sales_customers", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "company_id", default: 1, null: false
  end

  create_table "sales_distributors", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "company_id"
    t.index ["company_id"], name: "index_sales_distributors_on_company_id"
  end

  create_table "sales_forecast_worksheets", force: :cascade do |t|
    t.bigint "inventory_product_id", null: false
    t.bigint "sales_forecast_id", null: false
    t.float "velocity"
    t.string "store_distribution"
    t.string "integer"
    t.date "starting_on"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["inventory_product_id"], name: "index_sales_forecast_worksheets_on_inventory_product_id"
    t.index ["sales_forecast_id"], name: "index_sales_forecast_worksheets_on_sales_forecast_id"
  end

  create_table "sales_forecasts", force: :cascade do |t|
    t.string "version_on"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "sales_order_lines", force: :cascade do |t|
    t.integer "line_number"
    t.string "description"
    t.bigint "po_qty"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "order_id"
    t.bigint "unit_id"
    t.money "po_price", scale: 2
    t.bigint "item_id"
    t.money "line_total", scale: 2
    t.integer "company_id", default: 1, null: false
    t.index ["item_id"], name: "index_sales.order_lines_on_inventory.item_id"
    t.index ["order_id"], name: "index_sales.order_lines_on_sales.order_id"
    t.index ["unit_id"], name: "index_sales.order_lines_on_settings.unit_id"
  end

  create_table "sales_orders", force: :cascade do |t|
    t.integer "order_number"
    t.datetime "order_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "po_number"
    t.datetime "po_ship_date"
    t.datetime "po_pickup_date"
    t.integer "customer_account_id"
    t.boolean "acknowledged", default: false
    t.string "inventory_status"
    t.boolean "dc_notified", default: false
    t.boolean "shipped", default: false
    t.boolean "invoiced", default: false
    t.integer "company_id", default: 1, null: false
    t.integer "bill_to_address_id"
    t.integer "ship_from_address_id"
    t.integer "ship_to_address_id"
  end

  create_table "sales_retail_chains", force: :cascade do |t|
    t.string "name"
    t.bigint "sales_distributor_id", null: false
    t.integer "stores"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["sales_distributor_id"], name: "index_sales_retail_chains_on_sales_distributor_id"
  end

  create_table "security_companies", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.string "subdomain"
  end

  create_table "security_user_companies", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "company_id", null: false
    t.index ["company_id"], name: "index_security_user_companies_on_company_id"
    t.index ["user_id"], name: "index_security_user_companies_on_user_id"
  end

  create_table "security_users", force: :cascade do |t|
    t.string "email"
    t.string "crypted_password"
    t.string "password_salt"
    t.string "persistence_token"
    t.string "single_access_token"
    t.string "perishable_token"
    t.integer "login_count", default: 0, null: false
    t.integer "failed_login_count", default: 0, null: false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string "current_login_ip"
    t.string "last_login_ip"
    t.boolean "active", default: false
    t.boolean "approved", default: false
    t.boolean "confirmed", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "company_id", default: 1, null: false
    t.boolean "admin", default: false, null: false
    t.index ["email"], name: "index_settings.users_on_email", unique: true
    t.index ["perishable_token"], name: "index_settings.users_on_perishable_token", unique: true
    t.index ["persistence_token"], name: "index_settings.users_on_persistence_token", unique: true
    t.index ["single_access_token"], name: "index_settings.users_on_single_access_token", unique: true
  end

  create_table "settings_account_addresses", force: :cascade do |t|
    t.integer "account_id"
    t.integer "address_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "company_id", default: 1, null: false
  end

  create_table "settings_account_relationships", force: :cascade do |t|
    t.bigint "parent_id"
    t.bigint "child_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "company_id", default: 1, null: false
    t.index ["child_id"], name: "index_settings.account_relationships_on_child_id"
    t.index ["parent_id"], name: "index_settings.account_relationships_on_parent_id"
  end

  create_table "settings_accounts", force: :cascade do |t|
    t.string "code"
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "default_address_id"
    t.integer "owner_id"
    t.string "owner_type"
    t.integer "company_id", default: 1, null: false
    t.index ["default_address_id"], name: "index_settings.accounts_on_address_id"
  end

  create_table "settings_addresses", force: :cascade do |t|
    t.string "line_1"
    t.string "city"
    t.string "state"
    t.string "postal_code"
    t.string "country"
    t.string "line_2"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name"
    t.string "code"
    t.integer "company_id"
    t.string "country_code"
  end

  create_table "settings_columns", force: :cascade do |t|
    t.bigint "filter_id", null: false
    t.string "attribute_name"
    t.string "sort_direction"
    t.string "search_string"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "user_id"
    t.integer "company_id"
    t.string "operator"
    t.index ["filter_id"], name: "index_settings_columns_on_filter_id"
  end

  create_table "settings_companies", force: :cascade do |t|
    t.string "name"
    t.string "value"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "company_id"
  end

  create_table "settings_filters", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "company_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "pathname"
    t.string "model_name"
    t.index ["company_id"], name: "index_settings_filters_on_company_id"
    t.index ["user_id"], name: "index_settings_filters_on_user_id"
  end

  create_table "settings_units", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "abbrev"
    t.integer "company_id", default: 1, null: false
    t.string "unit_type"
  end

  add_foreign_key "inventory_item_locations", "inventory_items", column: "item_id"
  add_foreign_key "inventory_item_locations", "inventory_locations", column: "location_id"
  add_foreign_key "inventory_item_lots", "inventory_items", column: "item_id"
  add_foreign_key "inventory_items", "settings_units", column: "base_unit_id"
  add_foreign_key "inventory_products", "sales_categories", column: "category_id"
  add_foreign_key "inventory_products", "sales_channels", column: "channel_id"
  add_foreign_key "inventory_receipt_items", "inventory_receipts", column: "receipt_id"
  add_foreign_key "inventory_shipment_items", "inventory_shipments", column: "shipment_id"
  add_foreign_key "inventory_transactions", "inventory_item_lots", column: "item_lot_id"
  add_foreign_key "inventory_transactions", "inventory_locations", column: "location_id"
  add_foreign_key "inventory_transactions", "inventory_transaction_types", column: "transaction_type_id"
  add_foreign_key "sales_forecast_worksheets", "inventory_products"
  add_foreign_key "sales_forecast_worksheets", "sales_forecasts"
  add_foreign_key "sales_order_lines", "sales_orders", column: "order_id"
  add_foreign_key "sales_retail_chains", "sales_distributors"
  add_foreign_key "security_user_companies", "security_companies", column: "company_id"
  add_foreign_key "security_user_companies", "security_users", column: "user_id"
  add_foreign_key "settings_account_relationships", "settings_accounts", column: "child_id"
  add_foreign_key "settings_account_relationships", "settings_accounts", column: "parent_id"
  add_foreign_key "settings_accounts", "settings_addresses", column: "default_address_id"
  add_foreign_key "settings_columns", "settings_filters", column: "filter_id"
  add_foreign_key "settings_filters", "security_companies", column: "company_id"
  add_foreign_key "settings_filters", "security_users", column: "user_id"
end
