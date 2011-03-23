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

end
