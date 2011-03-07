class CreateBattles < ActiveRecord::Migration
  def self.up
    create_table :battles do |t|
      t.integer :contender
      t.string :blurb
      t.timestamps
    end
  end

  def self.down
    drop_table :battles
  end
end
