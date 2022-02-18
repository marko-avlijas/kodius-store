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

ActiveRecord::Schema[7.0].define(version: 2022_02_17_122023) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.string "country", null: false
    t.string "city", null: false
    t.string "line1", null: false
    t.string "line2"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_addresses_on_user_id"
  end

  create_table "baskets", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "baskets_promotion_codes", id: false, force: :cascade do |t|
    t.bigint "basket_id", null: false
    t.bigint "promotion_code_id", null: false
    t.index ["promotion_code_id", "basket_id"], name: "index_baskets_promotion_codes_on_both_keys", unique: true
  end

  create_table "credit_cards", force: :cascade do |t|
    t.string "number", null: false
    t.date "expiry_date", null: false
    t.integer "cvv2", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_credit_cards_on_user_id"
  end

  create_table "line_items", force: :cascade do |t|
    t.bigint "product_id"
    t.integer "quantity", default: 1, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "basket_id"
    t.bigint "order_id"
    t.index ["basket_id"], name: "index_line_items_on_basket_id"
    t.index ["order_id"], name: "index_line_items_on_order_id"
    t.index ["product_id"], name: "index_line_items_on_product_id"
  end

  create_table "orders", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "orders_promotion_codes", id: false, force: :cascade do |t|
    t.bigint "order_id", null: false
    t.bigint "promotion_code_id", null: false
    t.index ["promotion_code_id", "order_id"], name: "index_orders_promotion_codes_on_promotion_code_id_and_order_id", unique: true
  end

  create_table "products", force: :cascade do |t|
    t.string "name", null: false
    t.decimal "price", precision: 8, scale: 2, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "promotion_codes", force: :cascade do |t|
    t.string "code", null: false
    t.decimal "amount", precision: 8, scale: 2, null: false
    t.string "type", null: false
    t.boolean "can_combine", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "quantity_discounts", force: :cascade do |t|
    t.bigint "product_id", null: false
    t.integer "quantity", null: false
    t.decimal "price", precision: 8, scale: 2, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_quantity_discounts_on_product_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "addresses", "users"
  add_foreign_key "credit_cards", "users"
  add_foreign_key "line_items", "baskets"
  add_foreign_key "line_items", "orders"
  add_foreign_key "line_items", "products"
  add_foreign_key "orders", "users"
  add_foreign_key "quantity_discounts", "products"
end
