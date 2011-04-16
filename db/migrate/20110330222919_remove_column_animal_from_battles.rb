class RemoveColumnAnimalFromBattles < ActiveRecord::Migration
  def self.up
    remove_column :battles, :animal
  end

  def self.down
    add_column :battles, :animal, :integer
  end
end
