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

ActiveRecord::Schema.define(:version => 20110330222919) do

  create_table "animals", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "bio"
    t.string   "quip"
    t.string   "strength"
    t.string   "weakness"
    t.string   "blood_type"
    t.string   "special_move"
  end

  create_table "battles", :force => true do |t|
    t.string   "blurb"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contentions", :force => true do |t|
    t.integer  "animal_id"
    t.integer  "battle_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
