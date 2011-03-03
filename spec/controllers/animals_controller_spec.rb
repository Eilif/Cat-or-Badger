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

  describe "get edit" do

    before(:each) do
      @a = Animal.create(:name => "Ashley")
      get :edit, :id => @a.to_param
    end

    it 'should respond with success' do
      response.should be_success
    end

    it 'should assign correct animal to @animal' do
      assigns(:animal).should eq(@a)
    end

  end

  describe "post to update with valid input" do

    before(:each) do
      @a = Animal.create(:name => "Abstacia")
      put :update, :id => @a.to_param, :animal => { :name => "Toquilda" }
    end

    it 'should redirect to root path' do
      response.should redirect_to(root_path)
    end

    it 'should assign new name to @animal' do
      Animal.last.name.should eq("Toquilda")
    end

  end

  describe "put to update with invalid input" do

    before(:each) do
      @a = Animal.create(:name => "Abstacia")
      put :update, :id => @a.to_param, :animal => { :name => "" }
    end

    it 'should render edit template' do
      response.should render_template(:edit)
    end

  end

  describe "get show" do

    before(:each) do
      @a = Animal.create(:name => "Chorrecht")
      get :show, :id => @a.to_param
    end

    it 'should respond with success' do
      response.should be_success
    end

    it 'should assign correct animal to @animal' do
      assigns(:animal).should eq(@a)
    end

  end

  describe "delete to destroy" do

    before(:each) do
      @a = Animal.create(:name => "Laguther")
      delete :destroy, :id => @a.to_param
    end

    it 'should redirect to root path' do
      response.should redirect_to(root_path)
    end

    it 'should delete the correct animal' do
      Animal.last.should be_nil
    end

  end

end
