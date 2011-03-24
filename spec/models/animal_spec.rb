require 'spec_helper'

describe Animal do

  it 'can have a name and an image' do
    a = Animal.create!(:name => "tufted leopard", :image => File.new(Rails.root + 'spec/fixtures/images/seagull.jpg'))
    a.name.should eq("tufted leopard")
    a.image.original_filename.should eq('seagull.jpg')
  end

  it 'must have a name' do
    a = Animal.new(:name => "", :image => File.new(Rails.root + 'spec/fixtures/images/seagull.jpg'))
    a.should_not be_valid
    a.should have(1).error_on(:name)
  end

  it 'must have an image' do
    a = Animal.new(:name => "Hildegard")
    a.should_not be_valid
    a.should have(1).error_on(:image_file_name)
  end

  it 'can have a bio, quip, blood type, special move, strength, and weakness' do
    a = Animal.create!(:name => "chester", :image => File.new(Rails.root + 'spec/fixtures/images/seagull.jpg'), :bio => "chester is crescent fresh.", :quip => "Super cres at best!", :blood_type => "polyester", :special_move => "psychedelic freakout", :strength => "not subject to reason", :weakness => "occasional mental meltdown")
    a.bio.should eq("chester is crescent fresh.")
    a.quip.should eq("Super cres at best!")
    a.blood_type.should eq("polyester")
    a.special_move.should eq("psychedelic freakout")
    a.strength.should eq("not subject to reason")
    a.weakness.should eq("occasional mental meltdown")
  end

end
