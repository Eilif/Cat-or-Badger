class ChangeDefaultOnVotesInBattles < ActiveRecord::Migration
  def self.up
    change_column :battles, :animal_1_vote, :integer, :default => 0
    change_column :battles, :animal_2_vote, :integer, :default => 0
    execute "update battles set animal_1_vote = 0 where animal_1_vote is null"
    execute "update battles set animal_2_vote = 0 where animal_2_vote is null"
  end

  def self.down
    change_column :battles, :animal_1_vote, :integer, :default => nil
    change_column :battles, :animal_2_vote, :integer, :default => nil
  end
end
