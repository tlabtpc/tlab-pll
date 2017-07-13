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

ActiveRecord::Schema.define(version: 20170713220200) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "action_items", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "assessment_nodes", force: :cascade do |t|
    t.integer  "assessment_id"
    t.integer  "node_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["assessment_id"], name: "index_assessment_nodes_on_assessment_id", using: :btree
    t.index ["node_id"], name: "index_assessment_nodes_on_node_id", using: :btree
  end

  create_table "assessment_referrals", force: :cascade do |t|
    t.integer  "assessment_id"
    t.integer  "referral_id"
    t.boolean  "is_useful",     default: false, null: false
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.index ["assessment_id"], name: "index_assessment_referrals_on_assessment_id", using: :btree
    t.index ["referral_id"], name: "index_assessment_referrals_on_referral_id", using: :btree
  end

  create_table "assessments", force: :cascade do |t|
    t.string   "token"
    t.datetime "submitted_at"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "counties", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cross_check_action_items", force: :cascade do |t|
    t.integer  "cross_check_id"
    t.integer  "action_item_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["action_item_id"], name: "index_cross_check_action_items_on_action_item_id", using: :btree
    t.index ["cross_check_id"], name: "index_cross_check_action_items_on_cross_check_id", using: :btree
  end

  create_table "cross_checks", force: :cascade do |t|
    t.text     "details"
    t.text     "deadlines"
    t.string   "caseworker_name"
    t.string   "caseworker_phone"
    t.string   "caseworker_email"
    t.string   "caseworker_organization"
    t.integer  "client_is_long_term"
    t.boolean  "client_is_homeless"
    t.boolean  "client_is_in_sf"
    t.integer  "client_has_consulted_attorney"
    t.integer  "support_level"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.integer  "assessment_id",                 null: false
  end

  create_table "nodes", force: :cascade do |t|
    t.integer  "parent_node_id"
    t.boolean  "terminal",       default: false, null: false
    t.string   "node_type"
    t.boolean  "is_category",    default: false, null: false
    t.boolean  "is_county",      default: false, null: false
    t.string   "title"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.boolean  "root",           default: false, null: false
    t.string   "tip"
    t.string   "description"
    t.string   "question"
    t.index ["parent_node_id"], name: "index_nodes_on_parent_node_id", using: :btree
  end

  create_table "referrals", force: :cascade do |t|
    t.integer  "terminal_node_id"
    t.string   "type"
    t.string   "title"
    t.text     "markdown_content"
    t.string   "link"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["terminal_node_id"], name: "index_referrals_on_terminal_node_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                            null: false
    t.string   "crypted_password"
    t.string   "salt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.boolean  "admin",            default: false, null: false
    t.string   "user_cookie"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
  end

end
