class DropContentions < ActiveRecord::Migration

  def self.up
    drop_table "contentions"
  end

  def self.down
    create_table "contentions", :force => true do |t|
      t.integer  "animal_id"
      t.integer  "battle_id"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

  end

end
