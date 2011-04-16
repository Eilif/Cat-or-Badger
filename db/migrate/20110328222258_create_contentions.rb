class CreateContentions < ActiveRecord::Migration
  def self.up
    create_table :contentions do |t|
      t.integer :animal_id
      t.integer :battle_id
      t.timestamps
    end
  end

  def self.down
    drop_table :contentions
  end
end
