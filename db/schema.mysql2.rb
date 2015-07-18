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

ActiveRecord::Schema.define(version: 20150718014315) do

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",           limit: 255, null: false
    t.integer  "sluggable_id",   limit: 4,   null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope",          limit: 191
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "thredded_categories", force: :cascade do |t|
    t.integer  "messageboard_id", limit: 4,   null: false
    t.string   "name",            limit: 255, null: false
    t.string   "description",     limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug",            limit: 191, null: false
  end

  add_index "thredded_categories", ["messageboard_id", "slug"], name: "index_thredded_categories_on_messageboard_id_and_slug", unique: true, using: :btree
  add_index "thredded_categories", ["messageboard_id"], name: "index_thredded_categories_on_messageboard_id", using: :btree

  create_table "thredded_images", force: :cascade do |t|
    t.integer  "post_id",     limit: 4
    t.integer  "width",       limit: 4
    t.integer  "height",      limit: 4
    t.string   "orientation", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "thredded_images", ["post_id"], name: "index_thredded_images_on_post_id", using: :btree

  create_table "thredded_messageboards", force: :cascade do |t|
    t.string   "name",                 limit: 255,                         null: false
    t.string   "slug",                 limit: 191
    t.text     "description",          limit: 65535
    t.string   "security",             limit: 255,   default: "public"
    t.string   "posting_permission",   limit: 255,   default: "anonymous"
    t.integer  "topics_count",         limit: 4,     default: 0
    t.integer  "posts_count",          limit: 4,     default: 0
    t.boolean  "closed",                             default: false,       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "filter",               limit: 255,   default: "markdown",  null: false
    t.integer  "private_topics_count", limit: 4,     default: 0
  end

  add_index "thredded_messageboards", ["closed"], name: "index_thredded_messageboards_on_closed", using: :btree
  add_index "thredded_messageboards", ["slug"], name: "index_thredded_messageboards_on_slug", using: :btree

  create_table "thredded_notification_preferences", force: :cascade do |t|
    t.boolean  "notify_on_mention",           default: true
    t.boolean  "notify_on_message",           default: true
    t.integer  "user_id",           limit: 4,                null: false
    t.integer  "messageboard_id",   limit: 4,                null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "thredded_notification_preferences", ["messageboard_id"], name: "index_thredded_notification_preferences_on_messageboard_id", using: :btree
  add_index "thredded_notification_preferences", ["user_id"], name: "index_thredded_notification_preferences_on_user_id", using: :btree

  create_table "thredded_post_notifications", force: :cascade do |t|
    t.string   "email",      limit: 255, null: false
    t.integer  "post_id",    limit: 4,   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "thredded_post_notifications", ["post_id"], name: "index_thredded_post_notifications_on_post_id", using: :btree

  create_table "thredded_posts", force: :cascade do |t|
    t.integer  "user_id",         limit: 4
    t.text     "content",         limit: 65535
    t.string   "ip",              limit: 255
    t.string   "filter",          limit: 255,   default: "markdown"
    t.string   "source",          limit: 255,   default: "web"
    t.integer  "postable_id",     limit: 4
    t.integer  "messageboard_id", limit: 4,                          null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "postable_type",   limit: 191
  end

  add_index "thredded_posts", ["content"], name: "index_thredded_posts_on_content", type: :fulltext
  add_index "thredded_posts", ["messageboard_id"], name: "index_thredded_posts_on_messageboard_id", using: :btree
  add_index "thredded_posts", ["postable_id", "postable_type"], name: "index_thredded_posts_on_postable_id_and_postable_type", using: :btree
  add_index "thredded_posts", ["postable_id"], name: "index_thredded_posts_on_postable_id", using: :btree
  add_index "thredded_posts", ["user_id"], name: "index_thredded_posts_on_user_id", using: :btree

  create_table "thredded_private_topics", force: :cascade do |t|
    t.integer  "user_id",         limit: 4,               null: false
    t.integer  "last_user_id",    limit: 4,               null: false
    t.string   "title",           limit: 255,             null: false
    t.string   "slug",            limit: 191,             null: false
    t.integer  "messageboard_id", limit: 4,               null: false
    t.integer  "posts_count",     limit: 4,   default: 0
    t.string   "hash_id",         limit: 191,             null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "thredded_private_topics", ["hash_id"], name: "index_thredded_private_topics_on_hash_id", using: :btree
  add_index "thredded_private_topics", ["messageboard_id"], name: "index_thredded_private_topics_on_messageboard_id", using: :btree
  add_index "thredded_private_topics", ["slug"], name: "index_thredded_private_topics_on_slug", using: :btree

  create_table "thredded_private_users", force: :cascade do |t|
    t.integer  "private_topic_id", limit: 4
    t.integer  "user_id",          limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "read",                       default: false
  end

  add_index "thredded_private_users", ["private_topic_id"], name: "index_thredded_private_users_on_private_topic_id", using: :btree
  add_index "thredded_private_users", ["read"], name: "index_thredded_private_users_on_read", using: :btree
  add_index "thredded_private_users", ["user_id"], name: "index_thredded_private_users_on_user_id", using: :btree

  create_table "thredded_roles", force: :cascade do |t|
    t.string   "level",           limit: 255
    t.integer  "user_id",         limit: 4
    t.integer  "messageboard_id", limit: 4
    t.datetime "last_seen"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "thredded_roles", ["messageboard_id"], name: "index_thredded_roles_on_messageboard_id", using: :btree
  add_index "thredded_roles", ["user_id"], name: "index_thredded_roles_on_user_id", using: :btree

  create_table "thredded_topic_categories", force: :cascade do |t|
    t.integer "topic_id",    limit: 4, null: false
    t.integer "category_id", limit: 4, null: false
  end

  add_index "thredded_topic_categories", ["category_id"], name: "index_thredded_topic_categories_on_category_id", using: :btree
  add_index "thredded_topic_categories", ["topic_id"], name: "index_thredded_topic_categories_on_topic_id", using: :btree

  create_table "thredded_topics", force: :cascade do |t|
    t.integer  "user_id",         limit: 4,                   null: false
    t.integer  "last_user_id",    limit: 4,                   null: false
    t.string   "title",           limit: 255,                 null: false
    t.string   "slug",            limit: 191,                 null: false
    t.integer  "messageboard_id", limit: 4,                   null: false
    t.integer  "posts_count",     limit: 4,   default: 0,     null: false
    t.boolean  "sticky",                      default: false, null: false
    t.boolean  "locked",                      default: false, null: false
    t.string   "hash_id",         limit: 191,                 null: false
    t.string   "type",            limit: 191
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "thredded_topics", ["hash_id"], name: "index_thredded_topics_on_hash_id", using: :btree
  add_index "thredded_topics", ["messageboard_id", "slug"], name: "index_thredded_topics_on_messageboard_id_and_slug", unique: true, using: :btree
  add_index "thredded_topics", ["messageboard_id"], name: "index_thredded_topics_on_messageboard_id", using: :btree
  add_index "thredded_topics", ["title"], name: "index_thredded_topics_on_title", type: :fulltext
  add_index "thredded_topics", ["user_id"], name: "index_thredded_topics_on_user_id", using: :btree

  create_table "thredded_user_details", force: :cascade do |t|
    t.integer  "user_id",            limit: 4,                 null: false
    t.datetime "latest_activity_at"
    t.integer  "posts_count",        limit: 4, default: 0
    t.integer  "topics_count",       limit: 4, default: 0
    t.boolean  "superadmin",                   default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "thredded_user_details", ["latest_activity_at"], name: "index_thredded_user_details_on_latest_activity_at", using: :btree
  add_index "thredded_user_details", ["user_id"], name: "index_thredded_user_details_on_user_id", using: :btree

  create_table "thredded_user_preferences", force: :cascade do |t|
    t.integer  "user_id",    limit: 4,                                          null: false
    t.string   "time_zone",  limit: 191, default: "Eastern Time (US & Canada)"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "thredded_user_preferences", ["user_id"], name: "index_thredded_user_preferences_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "email",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
