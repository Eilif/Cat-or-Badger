class AddVotesColumnsToBattles < ActiveRecord::Migration
  def self.up
    add_column :battles, :animal_1_vote, :integer
    add_column :battles, :animal_2_vote, :integer
  end

  def self.down
    remove_column :battles, :animal_1_vote
    remove_column :battles, :animal_2_vote
  end
end
