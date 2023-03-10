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

ActiveRecord::Schema.define(version: 20_221_203_063_339) do
  create_table 'comments', charset: 'utf8mb3', force: :cascade do |t|
    t.string 'text', limit: 200, null: false
    t.bigint 'user_id', null: false
    t.bigint 'diary_id', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['diary_id'], name: 'index_comments_on_diary_id'
    t.index ['user_id'], name: 'index_comments_on_user_id'
  end

  create_table 'diaries', charset: 'utf8mb3', force: :cascade do |t|
    t.string 'title', null: false
    t.text 'body', null: false
    t.boolean 'publish', default: false, null: false
    t.bigint 'user_id', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.string 'image'
    t.index %w[user_id created_at], name: 'index_diaries_on_user_id_and_created_at'
    t.index ['user_id'], name: 'index_diaries_on_user_id'
  end

  create_table 'entries', charset: 'utf8mb3', force: :cascade do |t|
    t.bigint 'user_id', null: false
    t.bigint 'room_id', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['room_id'], name: 'index_entries_on_room_id'
    t.index ['user_id'], name: 'index_entries_on_user_id'
  end

  create_table 'likes', charset: 'utf8mb3', force: :cascade do |t|
    t.bigint 'user_id', null: false
    t.bigint 'diary_id', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['diary_id'], name: 'index_likes_on_diary_id'
    t.index ['user_id'], name: 'index_likes_on_user_id'
  end

  create_table 'messages', charset: 'utf8mb3', force: :cascade do |t|
    t.bigint 'user_id', null: false
    t.bigint 'room_id', null: false
    t.string 'body', limit: 200, null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.boolean 'read', default: false
    t.index ['room_id'], name: 'index_messages_on_room_id'
    t.index ['user_id'], name: 'index_messages_on_user_id'
  end

  create_table 'notifications', charset: 'utf8mb3', force: :cascade do |t|
    t.integer 'visitor_id', null: false
    t.integer 'visited_id', null: false
    t.integer 'diary_id'
    t.integer 'comment_id'
    t.string 'action', default: '', null: false
    t.boolean 'checked', default: false, null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['comment_id'], name: 'index_notifications_on_comment_id'
    t.index ['diary_id'], name: 'index_notifications_on_diary_id'
    t.index ['visited_id'], name: 'index_notifications_on_visited_id'
    t.index ['visitor_id'], name: 'index_notifications_on_visitor_id'
  end

  create_table 'relationships', charset: 'utf8mb3', force: :cascade do |t|
    t.integer 'follower_id'
    t.integer 'followed_id'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['followed_id'], name: 'index_relationships_on_followed_id'
    t.index %w[follower_id followed_id], name: 'index_relationships_on_follower_id_and_followed_id', unique: true
    t.index ['follower_id'], name: 'index_relationships_on_follower_id'
  end

  create_table 'rooms', charset: 'utf8mb3', force: :cascade do |t|
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end

  create_table 'users', charset: 'utf8mb3', force: :cascade do |t|
    t.string 'provider', default: 'email', null: false
    t.string 'uid', default: '', null: false
    t.string 'encrypted_password', default: '', null: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.boolean 'allow_password_change', default: false
    t.datetime 'remember_created_at'
    t.string 'confirmation_token'
    t.datetime 'confirmed_at'
    t.datetime 'confirmation_sent_at'
    t.string 'unconfirmed_email'
    t.string 'name', limit: 12, null: false
    t.string 'image'
    t.string 'email', null: false
    t.text 'tokens'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.integer 'sign_in_count', default: 0, null: false
    t.datetime 'current_sign_in_at'
    t.datetime 'last_sign_in_at'
    t.string 'current_sign_in_ip'
    t.string 'last_sign_in_ip'
    t.integer 'sex', default: 0, null: false
    t.integer 'age', default: 0, null: false
    t.integer 'department', default: 0, null: false
    t.string 'disease', limit: 25, default: '', null: false
    t.string 'favorite', limit: 25, default: '', null: false
    t.string 'profile', limit: 400, default: '', null: false
    t.boolean 'admin', default: false, null: false
    t.boolean 'is_setup', default: false, null: false
    t.boolean 'is_gest', default: false, null: false
    t.index ['confirmation_token'], name: 'index_users_on_confirmation_token', unique: true
    t.index ['email'], name: 'index_users_on_email', unique: true
    t.index ['reset_password_token'], name: 'index_users_on_reset_password_token', unique: true
    t.index %w[uid provider], name: 'index_users_on_uid_and_provider', unique: true
  end

  add_foreign_key 'comments', 'diaries'
  add_foreign_key 'comments', 'users'
  add_foreign_key 'diaries', 'users'
  add_foreign_key 'entries', 'rooms'
  add_foreign_key 'entries', 'users'
  add_foreign_key 'likes', 'diaries'
  add_foreign_key 'likes', 'users'
  add_foreign_key 'messages', 'rooms'
  add_foreign_key 'messages', 'users'
end
