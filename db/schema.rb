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

ActiveRecord::Schema.define(version: 20180225161508) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "character_comics", force: :cascade do |t|
    t.bigint "character_id"
    t.bigint "comic_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["character_id"], name: "index_character_comics_on_character_id"
    t.index ["comic_id"], name: "index_character_comics_on_comic_id"
  end

  create_table "characters", force: :cascade do |t|
    t.string "char_id"
    t.string "name"
    t.string "image"
    t.datetime "modified"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "comic_chars", force: :cascade do |t|
    t.bigint "comic_id"
    t.bigint "character_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["character_id"], name: "index_comic_chars_on_character_id"
    t.index ["comic_id"], name: "index_comic_chars_on_comic_id"
  end

  create_table "comics", force: :cascade do |t|
    t.string "title"
    t.string "cover_number"
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "character_comics", "characters"
  add_foreign_key "character_comics", "comics"
  add_foreign_key "comic_chars", "characters"
  add_foreign_key "comic_chars", "comics"
end
