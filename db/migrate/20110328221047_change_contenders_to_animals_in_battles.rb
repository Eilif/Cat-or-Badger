class ChangeContendersToAnimalsInBattles < ActiveRecord::Migration
  def self.up
    remove_column :battles, :contender
    add_column :battles, :animal, :integer
  end

  def self.down
    add_column :battles, :contender, :integer
    remove_column :battles, :animal
  end
end
