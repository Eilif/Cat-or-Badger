require 'spec_helper'

describe Story do

  before(:each) do
    @squiggles = Animal.create!(:name => "squiggles",
      :image => File.new(Rails.root + 'spec/fixtures/images/seagull.jpg'))
    @arbitrary = Animal.create!(:name => "arbitrary", 
      :image => File.new(Rails.root + 'spec/fixtures/images/seagull.jpg'))
    @user = User.create!(:username => "Sir_Chugsalot",
      :email => "choochoo@rail.yard")
    @battle = Battle.create!(:animal_1 => @squiggles, :animal_2 => @arbitrary)
    @story = Story.create!(:story_text => "Badger should win. That is all.",
      :title => "Thoughts on a Fight", :user => @user, :battle => @battle)
  end

  it 'can have text' do
    @story.story_text.should eq("Badger should win. That is all.")
  end

  it 'must have text' do
    @story2 = Story.new(:title => "Thoughts on a Fight", :user => @user,
      :battle => @battle)
    @story2.should_not be_valid
    @story2.should have(1).error_on(:story_text)
  end

  it 'can have user' do
    @story.user.should eq(@user)
  end

  it 'must have user' do
    @story3 = Story.new(:story_text => "Badger should win. That is all.",
      :title => "Thoughts on a Fight", :battle => @battle)
    @story3.should_not be_valid
    @story3.should have(1).error_on(:user)
  end

  it 'can have battle' do
    @story.battle.should eq(@battle)
  end

  it 'must have battle' do
    @story4 = Story.new(:story_text => "Badger should win. That is all.",
      :title => "Thoughts on a Fight", :user => @user)
    @story4.should_not be_valid
    @story4.should have(1).error_on(:battle)
  end

  it 'can have title' do
    @story.title.should eq("Thoughts on a Fight")
  end

end
