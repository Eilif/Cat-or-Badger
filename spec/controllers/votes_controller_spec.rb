require 'spec_helper'

describe VotesController do

  before(:each) do
    @test_image = Rails.root + "spec/fixtures/images/seagull.jpg"
    @file = Rack::Test::UploadedFile.new(@test_image, "image/jpeg")
    @terrence = Animal.create!(:name => "Terrence", :image => @file)
    @lawrence = Animal.create!(:name => "Lawrence", :image => @file)
    @hortence = Animal.create!(:name => "Hortence", :image => @file)
    @battle = Battle.create!(:animal_1 => @terrence, :animal_2 => @lawrence)
  end

  describe 'post to create with valid animal_id' do

     before(:each) { post :create, { :battle_id => @battle.id, :animal_id => @terrence.id } }

    it 'should increment vote on correct animal' do
      @battle.reload
      @battle.animal_1_vote.should eq(1)
      @battle.animal_2_vote.should eq(nil)
    end

    it 'should redirect to correct battle' do
      response.should redirect_to(battle_path(@battle))
    end

  end

  describe 'post to create with invalid animal_id' do

    before(:each) { post :create, { :battle_id => @battle.id, :animal_id => @hortence.id } }

    it 'should not increment votes' do
      @battle.reload
      @battle.animal_1_vote.should eq(nil)
      @battle.animal_2_vote.should eq(nil)
    end

    it 'should redirect to correct battle' do
      response.should redirect_to(battle_path(@battle))
    end

  end

end
