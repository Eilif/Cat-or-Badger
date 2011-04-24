class RenameAnimalColumnsInBattles < ActiveRecord::Migration
  def self.up
    rename_column :battles, :animal_1, :animal_1_id
    rename_column :battles, :animal_2, :animal_2_id
  end

  def self.down
    rename_column :battles, :animal_1_id, :animal_1
    rename_column :battles, :animal_2_id, :animal_2
  end
end
