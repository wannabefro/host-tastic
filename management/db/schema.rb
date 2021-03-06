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

ActiveRecord::Schema.define(version: 20141025144257) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "departments", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "departments", ["name"], name: "index_departments_on_name", unique: true, using: :btree

  create_table "histories", force: true do |t|
    t.integer  "ticket_id",  null: false
    t.string   "notes",      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "histories", ["ticket_id"], name: "index_histories_on_ticket_id", using: :btree

  create_table "responses", force: true do |t|
    t.text     "body",       null: false
    t.integer  "staff_id"
    t.integer  "ticket_id",  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "responses", ["staff_id"], name: "index_responses_on_staff_id", using: :btree
  add_index "responses", ["ticket_id"], name: "index_responses_on_ticket_id", using: :btree

  create_table "tickets", force: true do |t|
    t.string   "name",                          null: false
    t.string   "email",                         null: false
    t.string   "subject"
    t.integer  "department_id",                 null: false
    t.text     "body",                          null: false
    t.string   "reference",                     null: false
    t.integer  "assigned_staff_id"
    t.integer  "status",            default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tickets", ["assigned_staff_id"], name: "index_tickets_on_assigned_staff_id", using: :btree
  add_index "tickets", ["department_id"], name: "index_tickets_on_department_id", using: :btree
  add_index "tickets", ["reference"], name: "index_tickets_on_reference", unique: true, using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
