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
      @lokki = Factory.create(:lokki)
      @susi_ihminen = Factory.create(:susi)
      post :create, :battle => { :animal_1_id => @lokki.to_param,
        :animal_2_id => @susi_ihminen.to_param, :blurb => "ah, ahem"
      }
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
      Battle.last.animal_1.name.should eq("Lokki")
      Battle.last.animal_2.name.should eq("Susi-Ihminen")
    end
    
  end

  describe 'post to create with invalid battle attributes' do

    before(:each) { post :create, :battle => { :blurb => "ultrabattle!",
      :animal_1 => @emptiness, :animal_2 => @noanimal } }

    it 'should not create new battle' do
      Battle.last.should be_nil
    end

    it 'should render new' do
      response.should render_template(:new)
    end

  end

  describe 'get to index' do

    before(:each) do
      5.times do
        Factory.create(:battle)
      end
      get :index
    end

    it 'should have five battles' do
      Battle.count.should eq(5)
    end

    it 'should assign all battles from newest to oldest to @battle' do
      assigns(:battles).should eq(Battle.all.reverse)
    end

  end

  describe 'get to show' do

    before(:each) do
      @battle = Factory.create(:battle)
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
      @battle = Factory.create(:battle)
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
      @b = Factory.create(:battle)
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
      @b = Factory.create(:battle)
      @koira = Factory.create(:koira)
      post :update, :id => @b.to_param, :battle => {
        :animal_1_id => @koira.to_param
      }
    end

    it 'should assign new animal to animal_names' do
      Battle.last.animal_1.name.should eq("KarhuKoira")
      Battle.last.animal_2.name.should eq("Susi-Ihminen")
    end

    it 'should redirect to root path' do
      response.should redirect_to(root_path)
    end

  end

  describe 'post to update with invalid battle input' do

    before(:each) do
      @b = Factory.create(:battle)
      post :update, :id => @b.to_param, :battle => { :animal_1 => @emptiness }
    end

    it 'should render edit' do
      response.should render_template(:edit)
    end

  end

  describe 'get newest' do

    before(:each) do
      @battle = Factory.create(:battle)
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
