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

ActiveRecord::Schema[7.0].define(version: 2023_03_13_115929) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "post_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "content"
    t.index ["post_id"], name: "index_comments_on_post_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "favorites", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "post_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_favorites_on_post_id"
    t.index ["user_id"], name: "index_favorites_on_user_id"
  end

  create_table "fine_print_contracts", id: :serial, force: :cascade do |t|
    t.string "name", null: false
    t.integer "version"
    t.string "title", null: false
    t.text "content", null: false
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.index ["name", "version"], name: "index_fine_print_contracts_on_name_and_version", unique: true
  end

  create_table "fine_print_signatures", id: :serial, force: :cascade do |t|
    t.integer "contract_id", null: false
    t.string "user_type", null: false
    t.integer "user_id", null: false
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.boolean "is_implicit", default: false, null: false
    t.index ["contract_id"], name: "index_fine_print_signatures_on_contract_id"
    t.index ["user_id", "user_type", "contract_id"], name: "index_fine_print_s_on_u_id_and_u_type_and_c_id", unique: true
  end

  create_table "friendships", force: :cascade do |t|
    t.bigint "asker_id"
    t.bigint "receiver_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status", default: 1
    t.index ["asker_id"], name: "index_friendships_on_asker_id"
    t.index ["receiver_id"], name: "index_friendships_on_receiver_id"
  end

  create_table "posts", force: :cascade do |t|
    t.text "content"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "spotify_track_id"
    t.string "album_cover_url"
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "username"
    t.string "provider"
    t.string "uid"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "comments", "posts"
  add_foreign_key "comments", "users"
  add_foreign_key "favorites", "posts"
  add_foreign_key "favorites", "users"
  add_foreign_key "friendships", "users", column: "asker_id"
  add_foreign_key "friendships", "users", column: "receiver_id"
  add_foreign_key "posts", "users"
end
