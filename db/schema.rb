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

ActiveRecord::Schema.define(version: 20150529224742) do

  create_table "game2048s", force: :cascade do |t|
    t.string   "board1"
    t.string   "board2"
    t.boolean  "player1turn"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "pid1"
    t.integer  "pid2"
    t.string   "msg1"
    t.string   "msg2"
    t.boolean  "game_over",   default: false
  end

  add_index "game2048s", ["pid1"], name: "index_game2048s_on_pid1"
  add_index "game2048s", ["pid2"], name: "index_game2048s_on_pid2"

  create_table "games", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.string   "image_url"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "lobby2048s", force: :cascade do |t|
    t.integer  "pid"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.boolean  "taken",      default: false
  end

  add_index "lobby2048s", ["pid"], name: "index_lobby2048s_on_pid"

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",           null: false
    t.string   "encrypted_password",     default: "",           null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,            null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "rating",                 default: 1000.0
    t.string   "gamer_tag",              default: "Yam Player"
    t.string   "description"
    t.string   "profile_image",          default: "Happy"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
