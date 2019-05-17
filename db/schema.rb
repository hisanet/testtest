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

ActiveRecord::Schema.define(version: 2019_03_21_234218) do

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.boolean "mainte_add"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "corporations", force: :cascade do |t|
    t.string "name"
    t.string "name_kana"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "hmodels", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ord_details", force: :cascade do |t|
    t.integer "order_id"
    t.integer "product_id"
    t.integer "unit_price"
    t.integer "quantity"
    t.integer "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "mainte_bool", default: true, null: false
    t.integer "mainte"
    t.integer "mainte_yearprice"
    t.integer "row_order"
  end

  create_table "order_details", force: :cascade do |t|
    t.integer "order_id"
    t.integer "produict_id"
    t.integer "unit_price"
    t.integer "quantity"
    t.integer "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "orders", force: :cascade do |t|
    t.string "name"
    t.integer "corporation_id"
    t.integer "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "ord_date"
    t.integer "ritu", default: 0
    t.integer "kanyuu_price"
    t.integer "mainte_price"
    t.integer "mainte_year_price", default: 0
    t.integer "mainte_year", default: 0
    t.integer "mainte_type", default: 0
    t.float "mainte_discount", default: 0.0
    t.integer "mainte_month", default: 0
    t.integer "mainte_discount_price", default: 0
    t.integer "mainte_discount_month", default: 0
    t.float "mainte_discount_add", default: 0.0
    t.integer "virus_soft_price", default: 0
    t.integer "virus_soft_ics", default: 0
    t.integer "virus_soft_other", default: 0
    t.float "mainte_sprit_price", default: 0.0
    t.float "mainte_sprit_discount_price", default: 0.0
    t.integer "mainte_sprit_price_total", default: 0
    t.integer "mainte_sprit_discount_price_total", default: 0
    t.integer "repayment", default: 0
    t.text "other"
    t.integer "tax_price", default: 0
    t.integer "total", default: 0
  end

  create_table "products", force: :cascade do |t|
    t.string "code"
    t.string "name"
    t.string "name_kana"
    t.integer "price"
    t.integer "purchase_cost"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "category_id"
    t.integer "mainte_yearprice"
  end

  create_table "sales", force: :cascade do |t|
    t.integer "user_id"
    t.integer "sale_co"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "teams", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "age"
    t.integer "team_id"
    t.integer "row_order"
  end

end
