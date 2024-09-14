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

ActiveRecord::Schema[7.1].define(version: 2024_09_08_162234) do
  create_table "admin_users", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "name"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "blacklist_tokens", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "token", null: false
    t.datetime "blacklisted_at", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["token"], name: "index_blacklist_tokens_on_token", unique: true
  end

  create_table "cart_items", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "product_variant_id", null: false
    t.integer "quantity", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_variant_id"], name: "index_cart_items_on_product_variant_id"
    t.index ["user_id"], name: "index_cart_items_on_user_id"
  end

  create_table "categories", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "parent_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image_url"
    t.index ["parent_id"], name: "index_categories_on_parent_id"
  end

  create_table "colors", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "color", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "inquiries", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_id"
    t.string "name"
    t.string "email"
    t.text "message"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_inquiries_on_user_id"
  end

  create_table "likes", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "target_type", null: false
    t.bigint "target_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["target_type", "target_id"], name: "index_likes_on_target"
    t.index ["user_id"], name: "index_likes_on_user_id"
  end

  create_table "order_items", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "order_id", null: false
    t.bigint "product_variant_id", null: false
    t.integer "quantity", null: false
    t.integer "price", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_order_items_on_order_id"
    t.index ["product_variant_id"], name: "index_order_items_on_product_variant_id"
  end

  create_table "orders", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.integer "total_amount", null: false
    t.integer "total_amount_with_tax", null: false
    t.integer "status", null: false
    t.string "shipping_address"
    t.string "customer_name"
    t.string "stripe_checkout_session_id"
    t.string "stripe_charge_id"
    t.integer "payment_status"
    t.string "error_message"
    t.string "payment_url"
    t.datetime "payment_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["stripe_charge_id"], name: "index_orders_on_stripe_charge_id", unique: true
    t.index ["stripe_checkout_session_id"], name: "index_orders_on_stripe_checkout_session_id", unique: true
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "product_variants", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "product_id", null: false
    t.bigint "size_id", null: false
    t.bigint "color_id", null: false
    t.string "sku", null: false
    t.integer "stock_quantity"
    t.string "image_url"
    t.boolean "is_main_image_product", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["color_id"], name: "index_product_variants_on_color_id"
    t.index ["product_id"], name: "index_product_variants_on_product_id"
    t.index ["size_id"], name: "index_product_variants_on_size_id"
    t.index ["sku"], name: "index_product_variants_on_sku", unique: true
  end

  create_table "products", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.string "description"
    t.integer "price", null: false
    t.bigint "category_id", null: false
    t.integer "gender"
    t.integer "recommendation_score"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_products_on_category_id"
  end

  create_table "reviews", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "product_variant_id", null: false
    t.integer "rating", null: false
    t.string "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_variant_id"], name: "index_reviews_on_product_variant_id"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "sizes", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "size", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "email", null: false
    t.string "last_name", null: false
    t.string "first_name", null: false
    t.string "last_name_furigana", null: false
    t.string "first_name_furigana", null: false
    t.string "postal_code", null: false
    t.string "prefecture", null: false
    t.string "city", null: false
    t.string "town", null: false
    t.string "chome", null: false
    t.string "banchi", null: false
    t.string "building_name", null: false
    t.string "mobile_phone"
    t.integer "gender"
    t.string "occupation"
    t.date "birthday"
    t.boolean "approved", default: false
    t.string "stripe_customer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "password_digest", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["stripe_customer_id"], name: "index_users_on_stripe_customer_id", unique: true
  end

  add_foreign_key "cart_items", "product_variants"
  add_foreign_key "cart_items", "users"
  add_foreign_key "categories", "categories", column: "parent_id"
  add_foreign_key "inquiries", "users"
  add_foreign_key "order_items", "orders"
  add_foreign_key "order_items", "product_variants"
  add_foreign_key "orders", "users"
  add_foreign_key "product_variants", "colors"
  add_foreign_key "product_variants", "products"
  add_foreign_key "product_variants", "sizes"
  add_foreign_key "products", "categories"
  add_foreign_key "reviews", "product_variants"
  add_foreign_key "reviews", "users"
end
