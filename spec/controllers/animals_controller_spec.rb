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

  describe "post to create with valid animal attributes" do

    before(:each) { post :create, :animal => { :name => "Terrence" } }

    it 'should redirect to root path' do
      response.should redirect_to(root_path)
    end

    it 'should create an animal' do
      Animal.last.name.should eq("Terrence")
    end

    it 'should assign an animal to @animal' do
      assigns(:animal).should eq(Animal.last)
    end

  end

  describe "post to create with invalid animal attributes" do

    before(:each) { post :create, :animal => { :name => "" } }

    it 'should render new' do
      response.should render_template(:new)
    end

  end

  describe "get index" do

    before :each do
      5.times{ Animal.create(:name => "Eustace") }
      get :index
    end

    it 'should respond with success' do
      response.should be_success
    end

    it 'should assign all animals to @animals' do
      assigns(:animals).should eq(Animal.all.reverse)
    end

  end

end
