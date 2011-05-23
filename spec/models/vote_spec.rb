require 'spec_helper'

describe Vote do

  before(:each) do
    @squiggles = Animal.create!(:name => "squiggles",
      :image => File.new(Rails.root + 'spec/fixtures/images/seagull.jpg'))
    @arbitrary = Animal.create!(:name => "arbitrary", 
      :image => File.new(Rails.root + 'spec/fixtures/images/seagull.jpg'))
    @battle = Battle.create!(:animal_1 => @squiggles, :animal_2 => @arbitrary)
    @eilif = Factory.create(:user)
  end

  it 'can have a battle' do
    @vote = Vote.new(:battle => @battle, :animal => @squiggles,
      :user => @eilif, :weight => 10)
    @vote.battle.animal_2.name.should eq("arbitrary")
  end

  it 'must have a battle' do
    @vote = Vote.new(:animal => @squiggles, :user => @eilif, :weight => 10)
    @vote.should_not be_valid
    @vote.should have(1).error_on(:battle)
  end

  it 'can have an animal' do
    @vote = Vote.new(:battle => @battle, :animal => @squiggles,
      :user => @eilif, :weight => 10)
    @vote.animal.name.should eq("squiggles")
  end

  it 'must have an animal_id' do
    @vote = Vote.new(:battle => @battle, :user => @eilif, :weight => 10)
    @vote.should_not be_valid
    @vote.should have(1).error_on(:animal)
  end

  it 'can have a user_id' do
    @vote = Vote.new(:battle => @battle, :animal => @squiggles,
      :user => @eilif, :weight => 10)
    @vote.user.username.should eq("eilif")
  end

  it 'can have weight' do
    @vote = Vote.new(:battle => @battle, :animal => @squiggles,
      :user => @eilif, :weight => 10)
    @vote.should be_valid
    @vote.weight.should eq(10)
  end

  it 'must have a weight' do
    @vote = Vote.new(:battle => @battle, :animal => @squiggles,
      :user => @eilif)
    @vote.stub!(:set_weight)
    @vote.should_not be_valid
    @vote.should have(2).error_on(:weight)
  end

  it 'must have a weight of 1 or 10' do
    @vote = Vote.new(:battle => @battle, :animal => @squiggles,
      :user => @eilif, :weight => 9)
    @v = Vote.new(:battle => @battle, :animal => @squiggles,
      :user => @eilif, :weight => 1)
    @vote.should_not be_valid
    @vote.should have(1).error_on(:weight)
    @v.should be_valid
    @v.weight.should eq(1)
  end

end
