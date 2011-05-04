require 'spec_helper'

describe VotesController do

  before(:each) do
    @test_image = Rails.root + "spec/fixtures/images/seagull.jpg"
    @file = Rack::Test::UploadedFile.new(@test_image, "image/jpeg")
    @susi_ihminen = Animal.create!(:name => "Susi-Ihminen", :image => @file)
    @lawrence = Animal.create!(:name => "Lawrence", :image => @file)
    @hortence = Animal.create!(:name => "Hortence", :image => @file)
    @battle = Battle.create!(:animal_1 => @susi_ihminen, :animal_2 => @lawrence,
    :blurb => "it's a given")
    @eilif = User.create!(:username => "eilif", :email => "eilif@email.org")
  end

  describe 'get to new' do

    before(:each) { get :new }

    it 'should assign a vote to @vote' do
      assigns(:vote).should be
    end

  end

  describe 'post to create with valid vote attributes' do

    before(:each) do
      post :create, :vote => { :animal => @susi_ihminen, :battle => @battle,
      :user => @eilif, :weight => 10 }
    end

    it 'should assign a vote to @vote' do
      assigns(:vote).should eq(Vote.last)
    end

    it 'should save correct vote attributes' do
      Vote.last.animal.name.should eq("Susi-Ihminen")
      Vote.last.battle.blurb.should eq("it's a given")
      Vote.last.user.username.should eq("eilif")
      Vote.last.weight.should eq(10)
    end

    it 'should redirect to root path' do
      response.should redirect_to(root_path)
    end

  end

  describe 'post to create with invalid vote attributes' do

    before(:each) do
      post :create, :vote => { :battle => @battle, :user => @eilif,
      :weight => 10 }
    end

    it 'should not save vote' do
      Vote.last.should eq(nil)
    end

    it 'should flash error message' do
      flash[:message].should eq("You don't count! Sorry, something went wrong and we didn't receive your vote. Head over to the contact page, send me an e-mail, and I'll see what I can do to fix it.")
    end

    it 'should redirect to root path' do
      response.should redirect_to(root_path)
    end

  end



#  describe 'post to create with valid animal_id' do

#     before(:each) { post :create, { :battle_id => @battle.id, :animal_id => @terrence.id } }

#    it 'should increment vote on correct animal' do
#      @battle.reload
#      @battle.animal_1_vote.should eq(1)
#      @battle.animal_2_vote.should eq(nil)
#    end

#    it 'should redirect to correct battle' do
#      response.should redirect_to(battle_path(@battle))
#    end

#  end

#  describe 'post to create with invalid animal_id' do

#    before(:each) { post :create, { :battle_id => @battle.id, :animal_id => @hortence.id } }

#    it 'should not increment votes' do
#      @battle.reload
#      @battle.animal_1_vote.should eq(nil)
#      @battle.animal_2_vote.should eq(nil)
#    end

#    it 'should redirect to correct battle' do
#      response.should redirect_to(battle_path(@battle))
#    end

#  end

end
