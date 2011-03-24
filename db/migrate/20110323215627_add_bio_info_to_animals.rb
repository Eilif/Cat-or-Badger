class AddBioInfoToAnimals < ActiveRecord::Migration
  def self.up
    add_column :animals, :bio, :string
    add_column :animals, :quip, :string
    add_column :animals, :strength, :string
    add_column :animals, :weakness, :string
    add_column :animals, :blood_type, :string
    add_column :animals, :special_move, :string
  end

  def self.down
    remove_column :animals, :bio, :string
    remove_column :animals, :quip, :string
    remove_column :animals, :strength, :string
    remove_column :animals, :weakness, :string
    remove_column :animals, :blood_type, :string
    remove_column :animals, :special_move, :string
  end
end
