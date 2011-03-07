require 'spec_helper'

describe Animal do

  it 'can have a name' do
    a = Animal.create!(:name => "tufted leopard", :image => File.new(Rails.root + 'spec/fixtures/images/seagull.jpg'))
    a.name.should eq("tufted leopard")
  end

  it 'must have a name' do
    a = Animal.new(:name => "", :image => File.new(Rails.root + 'spec/fixtures/images/seagull.jpg'))
    a.should_not be_valid
    a.should have(1).error_on(:name)
  end

end
