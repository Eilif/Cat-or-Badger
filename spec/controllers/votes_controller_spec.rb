require 'spec_helper'

describe VotesController do

  describe 'get to new' do

    before(:each) { get :new }

    it 'should assign a vote to @vote' do
      assigns(:vote).should be
    end

  end

  describe 'post to create with valid vote attributes' do

    before(:each) do
      post :create, :battle_id => valid_battle.to_param, :vote => { :animal_id => 
      valid_animal_lokki.to_param, :user_id => valid_user_eilif.to_param,
      :weight => 10 }
    end

    it 'should assign a vote to @vote' do
      assigns(:vote).should eq(Vote.last)
    end

    it 'should save correct vote attributes' do
      Vote.last.animal.name.should eq("Lokki")
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
      post :create, :battle_id => valid_battle.to_param, :vote => { :user_id => 
      valid_user_eilif.to_param, :weight => 10 }
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

end
