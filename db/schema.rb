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

ActiveRecord::Schema[7.0].define(version: 2022_12_07_011012) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "pm_profiles", force: :cascade do |t|
    t.string "investment_strategy"
    t.string "ips"
    t.string "pm_notes"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_pm_profiles_on_user_id"
  end

  create_table "seed_migration_data_migrations", id: :serial, force: :cascade do |t|
    t.string "version"
    t.integer "runtime"
    t.datetime "migrated_on", precision: nil
  end

  create_table "stock_symbols", force: :cascade do |t|
    t.string "symbol"
    t.string "name"
    t.integer "ipo_year"
    t.string "country"
    t.string "sector"
    t.string "industry"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "trader_profiles", force: :cascade do |t|
    t.string "preferred_index1"
    t.string "preferred_index2"
    t.string "preferred_index3"
    t.string "trader_notes"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_trader_profiles_on_user_id"
  end

  create_table "trader_stocks", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "stock_symbol_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["stock_symbol_id"], name: "index_trader_stocks_on_stock_symbol_id"
    t.index ["user_id"], name: "index_trader_stocks_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.integer "portfolio_manager_id"
    t.string "first_name"
    t.string "last_name"
    t.string "accountName"
    t.string "email"
    t.string "password_digest"
    t.decimal "balance"
    t.string "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["portfolio_manager_id"], name: "index_users_on_portfolio_manager_id"
  end

  add_foreign_key "pm_profiles", "users", on_delete: :cascade
  add_foreign_key "trader_profiles", "users", on_delete: :cascade
  add_foreign_key "trader_stocks", "stock_symbols"
  add_foreign_key "trader_stocks", "users", on_delete: :cascade
  add_foreign_key "users", "users", column: "portfolio_manager_id"
end
