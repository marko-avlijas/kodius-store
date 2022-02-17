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

ActiveRecord::Schema[7.0].define(version: 2022_02_17_063824) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "baskets", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "baskets_promotion_codes", id: false, force: :cascade do |t|
    t.bigint "basket_id", null: false
    t.bigint "promotion_code_id", null: false
    t.index ["promotion_code_id", "basket_id"], name: "index_baskets_promotion_codes_on_both_keys", unique: true
  end

  create_table "line_items", force: :cascade do |t|
    t.bigint "product_id"
    t.bigint "product_bundle_id"
    t.bigint "basket_id", null: false
    t.integer "quantity", default: 1, null: false
    t.string "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["basket_id"], name: "index_line_items_on_basket_id"
    t.index ["product_bundle_id"], name: "index_line_items_on_product_bundle_id"
    t.index ["product_id"], name: "index_line_items_on_product_id"
  end

  create_table "product_bundles", force: :cascade do |t|
    t.bigint "product_id", null: false
    t.integer "quantity", null: false
    t.decimal "price", precision: 8, scale: 2, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_product_bundles_on_product_id"
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

  add_foreign_key "line_items", "baskets"
  add_foreign_key "line_items", "product_bundles"
  add_foreign_key "line_items", "products"
  add_foreign_key "product_bundles", "products"
end
