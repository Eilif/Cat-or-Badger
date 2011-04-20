class AddAnimalsToBattles < ActiveRecord::Migration
  def self.up
    add_column :battles, :animal_1, :integer
    add_column :battles, :animal_2, :integer
  end

  def self.down
    remove_column :battles, :animal_1, :integer
    remove_column :battles, :animal_2, :integer
  end
end
