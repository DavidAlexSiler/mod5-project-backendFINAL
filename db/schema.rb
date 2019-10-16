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

ActiveRecord::Schema.define(version: 2019_10_15_180724) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "follows", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "followee_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["followee_id"], name: "index_follows_on_followee_id"
    t.index ["user_id"], name: "index_follows_on_user_id"
  end

  create_table "playlist_songs", force: :cascade do |t|
    t.bigint "song_id"
    t.bigint "playlist_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["playlist_id"], name: "index_playlist_songs_on_playlist_id"
    t.index ["song_id"], name: "index_playlist_songs_on_song_id"
  end

  create_table "playlists", force: :cascade do |t|
    t.string "title"
    t.string "owner"
    t.string "image"
    t.text "description"
    t.boolean "collaborative"
    t.boolean "public"
    t.integer "followers"
    t.integer "length"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_playlists_on_user_id"
  end

  create_table "songs", force: :cascade do |t|
    t.string "title"
    t.string "artist"
    t.string "album"
    t.string "album_img"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "image"
    t.string "country"
    t.string "spotify_url"
    t.string "href"
    t.string "uri"
    t.string "spotify_id"
    t.string "access_token"
    t.string "refresh_token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "follows", "users"
  add_foreign_key "follows", "users", column: "followee_id"
end
