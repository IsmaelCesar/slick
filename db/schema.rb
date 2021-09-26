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

ActiveRecord::Schema.define(version: 2021_09_16_214921) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "chat_messages", force: :cascade do |t|
    t.bigint "message_id", null: false
    t.bigint "chat_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["chat_id"], name: "index_chat_messages_on_chat_id"
    t.index ["message_id"], name: "index_chat_messages_on_message_id"
  end

  create_table "chats", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "contact_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["contact_id"], name: "index_chats_on_contact_id"
    t.index ["user_id"], name: "index_chats_on_user_id"
  end

  create_table "friends", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "friend_id", null: false
    t.bigint "chat_id", null: false
    t.index ["chat_id"], name: "index_friends_on_chat_id"
    t.index ["user_id"], name: "index_friends_on_user_id"
  end

  create_table "group_invites", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "group_id", null: false
    t.boolean "is_accepted", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["group_id"], name: "index_group_invites_on_group_id"
    t.index ["user_id"], name: "index_group_invites_on_user_id"
  end

  create_table "groups", force: :cascade do |t|
    t.string "name"
    t.string "group_image_url"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_adm_id", null: false
    t.text "description"
    t.index ["user_adm_id"], name: "index_groups_on_user_adm_id"
  end

  create_table "messages", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.text "content"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "text_channel_messages", force: :cascade do |t|
    t.bigint "text_channel_id", null: false
    t.bigint "message_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["message_id"], name: "index_text_channel_messages_on_message_id"
    t.index ["text_channel_id"], name: "index_text_channel_messages_on_text_channel_id"
  end

  create_table "text_channels", force: :cascade do |t|
    t.string "name"
    t.bigint "group_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["group_id"], name: "index_text_channels_on_group_id"
  end

  create_table "text_thread_messages", force: :cascade do |t|
    t.bigint "text_thread_id", null: false
    t.bigint "message_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["message_id"], name: "index_text_thread_messages_on_message_id"
    t.index ["text_thread_id"], name: "index_text_thread_messages_on_text_thread_id"
  end

  create_table "text_threads", force: :cascade do |t|
    t.bigint "text_channel_message_id", null: false
    t.string "label"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["text_channel_message_id"], name: "index_text_threads_on_text_channel_message_id"
  end

  create_table "user_groups", force: :cascade do |t|
    t.bigint "group_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["group_id"], name: "index_user_groups_on_group_id"
    t.index ["user_id"], name: "index_user_groups_on_user_id"
  end

  create_table "user_invites", force: :cascade do |t|
    t.boolean "is_accepted", default: false
    t.integer "user_invite_id", null: false
    t.integer "user_invitee_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.boolean "online"
    t.string "status"
    t.string "user_image_url"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "chat_messages", "chats"
  add_foreign_key "chat_messages", "messages"
  add_foreign_key "chats", "users"
  add_foreign_key "chats", "users", column: "contact_id"
  add_foreign_key "friends", "users"
  add_foreign_key "friends", "users", column: "friend_id"
  add_foreign_key "group_invites", "groups"
  add_foreign_key "group_invites", "users"
  add_foreign_key "groups", "users", column: "user_adm_id"
  add_foreign_key "text_channel_messages", "messages"
  add_foreign_key "text_channel_messages", "text_channels"
  add_foreign_key "text_channels", "groups"
  add_foreign_key "text_thread_messages", "messages"
  add_foreign_key "text_thread_messages", "text_threads"
  add_foreign_key "text_threads", "text_channel_messages"
  add_foreign_key "user_groups", "groups"
  add_foreign_key "user_groups", "users"
  add_foreign_key "user_invites", "users", column: "user_invite_id"
  add_foreign_key "user_invites", "users", column: "user_invitee_id"
end
