require 'spec_helper'

describe Battle do

  before(:each) do
      @test_image = Rails.root + "spec/fixtures/images/seagull.jpg"
      @file = Rack::Test::UploadedFile.new(@test_image, "image/jpeg")
      @terrence = Animal.create!(:name => "Terrence", :image => @file)
      @lawrence = Animal.create!(:name => "Lawrence", :image => @file)
  end

  it 'can have two animals' do
    b = Battle.create!(:animal_1 => @terrence, :animal_2 => @lawrence)
    b.should be_valid
    b.animal_1.name.should eq("Terrence")
    b.animal_2.name.should eq("Lawrence")
  end

  it 'must have animal_2' do
    b = Battle.new(:animal_1 => @terrence)
    b.should_not be_valid
    b.should have(1).error_on(:animal_2)
  end

  it 'must have animal_1' do
    b = Battle.new(:animal_2 => @lawrence)
    b.should_not be_valid
    b.should have(1).error_on(:animal_1)
  end

  it 'can have blurb' do
    b = Battle.create!(:animal_1 => @terrence, :animal_2 => @lawrence, :blurb => "It's MF'ing on!")
    b.blurb.should eq("It's MF'ing on!")
  end

  it 'can increment votes on animals' do
    b = Battle.create!(:animal_1 => @terrence, :animal_2 => @lawrence)
    b.vote_for(@terrence.id)
    b.animal_1_vote.should eq(1)
  end

  it 'can increment votes multiple times on multiple animals' do
    b = Battle.create!(:animal_1 => @terrence, :animal_2 => @lawrence)
    5.times { b.vote_for(@terrence.id) }
    3.times { b.vote_for(@lawrence.id) }
    b.animal_1_vote.should eq(5)
    b.animal_2_vote.should eq(3)
  end

end
