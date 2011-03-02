require 'spec_helper'

describe Animal do

  it 'can have a name' do
    a = Animal.create!(:name => "tufted leopard")
    a.name.should eq("tufted leopard")
  end

end
