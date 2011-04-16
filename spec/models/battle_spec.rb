require 'spec_helper'

describe Battle do

  before(:each) do
      @test_image = Rails.root + "spec/fixtures/images/seagull.jpg"
      @file = Rack::Test::UploadedFile.new(@test_image, "image/jpeg")
      @terrence = Animal.create!(:name => "Terrence", :image => @file)
      @lawrence = Animal.create!(:name => "Lawrence", :image => @file)
      @hortence = Animal.create!(:name => "Hortence", :image => @file)
  end

  it 'can have two animals' do
    b = Battle.new
    [@terrence, @lawrence].each do |contender|
      b.contentions.build(:animal => contender, :battle => b)
    end
    b.should be_valid
    b.contentions.size.should eq(2)
  end

  it 'must have two animals' do
    b = Battle.new
    b.contentions.build(:animal => @terrence, :battle => b)
    b.should_not be_valid
    b.should have(1).error_on(:contentions)
  end

  it 'cannot have more than 2 animals' do
    b = Battle.new
    [@terrence, @lawrence, @hortence].each do |contender|
      b.contentions.build(:animal => contender, :battle => b)
    end
    b.should have(1).error_on(:contentions)
  end

end
