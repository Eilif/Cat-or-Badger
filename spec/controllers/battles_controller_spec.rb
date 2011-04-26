require 'spec_helper'

describe BattlesController do

  describe 'get to new' do

    before(:each) { get :new }

    it 'should respond with success' do
      response.should be_success
    end

    it 'should assign a battle to @battle' do
      assigns(:battle).should be
    end

  end

  describe 'post to create with valid battle attributes' do

    before(:each) do
      @test_image = Rails.root + "spec/fixtures/images/seagull.jpg"
      @file = Rack::Test::UploadedFile.new(@test_image, "image/jpeg")
      @terrence = Animal.create!(:name => "Terrence", :image => @file)
      @lawrence = Animal.create!(:name => "Lawrence", :image => @file)
      post :create, :battle => { :animal_1 => @terrence, :animal_2 => @lawrence, :blurb => "ah, ahem"}
    end

    it 'should redirect to root path' do
      response.should redirect_to(root_path)
    end

    it 'should create new battle' do
      Battle.last.blurb.should eq("ah, ahem")
    end

    it 'should assign a battle to @battle' do
      assigns(:battle).should eq(Battle.last)
    end

    it 'should have contentions with Terrence and Lawrence' do
      Battle.last.animal_1.name.should eq("Terrence")
      Battle.last.animal_2.name.should eq("Lawrence")
    end
    
  end

  describe 'post to create with invalid battle attributes' do

    before(:each) { post :create, :battle => { :blurb => "ultrabattle!", :animal_1 => @emptiness, :animal_2 => @noanimal } }

    it 'should not create new battle' do
      Battle.last.should be_nil
    end

    it 'should render new' do
      response.should render_template(:new)
    end

  end

  describe 'get to index' do

    before(:each) do
      @test_image = Rails.root + "spec/fixtures/images/seagull.jpg"
      @file = Rack::Test::UploadedFile.new(@test_image, "image/jpeg")
      @terrence = Animal.create!(:name => "Terrence", :image => @file)
      @lawrence = Animal.create!(:name => "Lawrence", :image => @file)
      5.times{ Battle.create!(:animal_1 => @terrence, :animal_2 => @lawrence, :blurb => "They're at it again") }
      get :index
    end

    it 'should respond with success' do
      response.should be_success
    end

    it 'should assign all battles from newest to oldest to @battle' do
      assigns(:battles).should eq(Battle.all.reverse)
    end

  end

  describe 'get to show' do

    before(:each) do
      @test_image = Rails.root + "spec/fixtures/images/seagull.jpg"
      @file = Rack::Test::UploadedFile.new(@test_image, "image/jpeg")
      @terrence = Animal.create!(:name => "Terrence", :image => @file)
      @lawrence = Animal.create!(:name => "Lawrence", :image => @file)
      @battle = Battle.create!(:animal_1 => @terrence, :animal_2 => @lawrence, :blurb => "They're at it again")
      get :show, :id => @battle.to_param
    end

    it 'should respond with success' do
      response.should be_success
    end

    it 'should show correct battle' do
      assigns(:battle).should eq(@battle)
    end

  end

  describe 'delete to destroy' do

     before(:each) do
      @test_image = Rails.root + "spec/fixtures/images/seagull.jpg"
      @file = Rack::Test::UploadedFile.new(@test_image, "image/jpeg")
      @terrence = Animal.create!(:name => "Terrence", :image => @file)
      @lawrence = Animal.create!(:name => "Lawrence", :image => @file)
      @battle = Battle.create!(:animal_1 => @terrence, :animal_2 => @lawrence, :blurb => "They're at it again")
      delete :destroy, :id => @battle.to_param
    end

    it 'should delete the correct battle' do
      Battle.last.should be_nil
    end

    it 'should redirect to root path' do
      response.should redirect_to(root_path)
    end
  
  end

  describe 'get edit' do

     before(:each) do
      @test_image = Rails.root + "spec/fixtures/images/seagull.jpg"
      @file = Rack::Test::UploadedFile.new(@test_image, "image/jpeg")
      @terrence = Animal.create!(:name => "Terrence", :image => @file)
      @lawrence = Animal.create!(:name => "Lawrence", :image => @file)
      @b = Battle.create!(:animal_1 => @terrence, :animal_2 => @lawrence, :blurb => "They're at it again")
      get :edit, :id => @b.to_param
    end

    it 'should respond with success' do
      response.should be_success
    end

    it 'should assign correct battle to @battle' do
      assigns(:battle).should eq(@b)
    end

  end

  describe 'post to update with valid battle input' do

    before(:each) do
      @test_image = Rails.root + "spec/fixtures/images/seagull.jpg"
      @file = Rack::Test::UploadedFile.new(@test_image, "image/jpeg")
      @terrence = Animal.create!(:name => "Terrence", :image => @file)
      @hortence = Animal.create!(:name => "Hortence", :image => @file)
      @lawrence = Animal.create!(:name => "Lawrence", :image => @file)
      @b = Battle.create!(:animal_1 => @terrence, :animal_2 => @hortence, :blurb => "They're at it again")
      post :update, :id => @b.to_param, :battle => { :animal_1 => @lawrence }
    end

    it 'should assign new animal to animal_names' do
      Battle.last.animal_1.name.should eq("Lawrence")
      Battle.last.animal_2.name.should eq("Hortence")
    end

    it 'should redirect to root path' do
      response.should redirect_to(root_path)
    end

  end

  describe 'post to update with invalid battle input' do

    before(:each) do
      @test_image = Rails.root + "spec/fixtures/images/seagull.jpg"
      @file = Rack::Test::UploadedFile.new(@test_image, "image/jpeg")
      @terrence = Animal.create!(:name => "Terrence", :image => @file)
      @lawrence = Animal.create!(:name => "Lawrence", :image => @file)
      @hortence = Animal.create!(:name => "Hortence", :image => @file)
      @b = Battle.create!(:animal_1 => @terrence, :animal_2 => @lawrence, :blurb => "They're at it again")
      post :update, :id => @b.to_param, :battle => { :animal_1 => @emptiness }
    end

    it 'should render edit' do
      response.should render_template(:edit)
    end
  end

  describe 'get newest' do

    before(:each) do
      @test_image = Rails.root + "spec/fixtures/images/seagull.jpg"
      @file = Rack::Test::UploadedFile.new(@test_image, "image/jpeg")
      @terrence = Animal.create!(:name => "Terrence", :image => @file)
      @lawrence = Animal.create!(:name => "Lawrence", :image => @file)
      @battle = Battle.create!(:animal_1 => @terrence, :animal_2 => @lawrence, :blurb => "They're at it again")
      get :newest, :id => @battle.to_param
    end

    it 'should respond with success' do
      response.should be_success
    end

    it 'should get the last battle' do
      assigns(:battle).should eq(@battle)
      @battle.should eq(Battle.last)
    end

  end

end
