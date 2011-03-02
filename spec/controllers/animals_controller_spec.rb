require 'spec_helper'

describe AnimalsController do

  describe "get to new" do
    before(:each) { get :new }

    it 'should respond with success' do
      response.should be_success
    end

    it 'should assign an animal to @animal' do
      assigns(:animal).should be
    end

  end

end
