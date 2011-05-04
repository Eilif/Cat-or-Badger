class CreateVotes < ActiveRecord::Migration
  def self.up
    create_table :votes do |t|
      t.integer :battle_id
      t.integer :animal_id
      t.integer :user_id
      t.integer :weight
      t.timestamps
    end
  end

  def self.down
    drop_table :votes
  end
end
