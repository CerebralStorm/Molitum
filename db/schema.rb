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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120720020036) do

  create_table "bid_items", :force => true do |t|
    t.string   "category"
    t.string   "description"
    t.float    "hours",       :default => 0.0
    t.float    "materials",   :default => 0.0
    t.float    "cost",        :default => 0.0
    t.integer  "bid_id"
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

  create_table "bids", :force => true do |t|
    t.string   "customer"
    t.string   "time_estimate"
    t.string   "materials_estimate"
    t.datetime "start_date"
    t.datetime "finish_date"
    t.string   "location"
    t.float    "subtotal",             :default => 0.0
    t.float    "total",                :default => 0.0
    t.boolean  "accepted",             :default => false
    t.integer  "company_id"
    t.string   "scope_of_work"
    t.string   "detail_of_work"
    t.float    "total_hours",          :default => 0.0
    t.float    "total_materials",      :default => 0.0
    t.float    "discount",             :default => 0.0
    t.string   "discount_description"
    t.float    "down_payment",         :default => 0.0
    t.float    "hourly_rate",          :default => 0.0
    t.datetime "created_at",                              :null => false
    t.datetime "updated_at",                              :null => false
  end

  create_table "companies", :force => true do |t|
    t.float    "income",     :default => 0.0
    t.float    "expense",    :default => 0.0
    t.string   "name"
    t.string   "email"
    t.string   "website"
    t.string   "address"
    t.string   "phone"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

  create_table "customers", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "address"
    t.string   "phone"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.integer  "company_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "invoice_items", :force => true do |t|
    t.string   "category"
    t.string   "description"
    t.float    "hours",       :default => 0.0
    t.float    "materials",   :default => 0.0
    t.float    "cost",        :default => 0.0
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

  create_table "invoices", :force => true do |t|
    t.integer  "customer_id"
    t.integer  "job_id"
    t.integer  "company_id"
    t.date     "billing_start"
    t.date     "billing_end"
    t.float    "total_due",     :default => 0.0
    t.boolean  "paid",          :default => false
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
  end

  create_table "job_expenses", :force => true do |t|
    t.string   "category"
    t.string   "description"
    t.float    "cost",        :default => 0.0
    t.integer  "job_id"
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

  create_table "jobs", :force => true do |t|
    t.string   "category"
    t.string   "hours"
    t.string   "materials"
    t.string   "location"
    t.float    "budget"
    t.string   "scope_of_work"
    t.string   "detail_of_work"
    t.datetime "start_date"
    t.datetime "finish_date"
    t.integer  "customer_id"
    t.integer  "company_id"
    t.float    "total_cost",     :default => 0.0
    t.float    "labor_cost",     :default => 0.0
    t.integer  "status",         :default => 0
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  create_table "time_clocks", :force => true do |t|
    t.integer  "start_time"
    t.integer  "end_time"
    t.integer  "hours"
    t.date     "work_date"
    t.boolean  "paid",       :default => false
    t.integer  "job_id"
    t.integer  "user_id"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "",    :null => false
    t.string   "encrypted_password",     :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.boolean  "admin",                  :default => false
    t.string   "name"
    t.float    "unpaid_hours",           :default => 0.0
    t.float    "paid_hours",             :default => 0.0
    t.float    "pay_rate",               :default => 0.0
    t.float    "total_hours",            :default => 0.0
    t.integer  "company_id"
    t.string   "city"
    t.string   "state"
    t.integer  "zip"
    t.string   "phone"
    t.string   "address"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
