require 'spec_helper'

describe StoriesController do

  describe 'get new' do

    before(:each) { get :new }

    it 'should assign story to @story' do
      assigns(:story).should be
    end

  end

  describe 'post to create with valid story info' do

    before(:each) do
      @battle = Factory.create(:battle)
      @user = Factory.create(:user)
      post :create, :battle_id => @battle.to_param, :story => {
        :user_id => @user.to_param, :title => "Thoughts on a Fight",
        :story_text => "Koira should win. That is all."
      }
    end

    it 'should assign story to @story' do
      assigns(:story).should eq(Story.last)
    end

    it 'should save correct info' do
      Story.last.story_text.should eq("Koira should win. That is all.")
      Story.last.battle.blurb.should eq("it's a given")
      Story.last.user.username.should eq("eilif")
      Story.last.title.should eq("Thoughts on a Fight")
    end

    it 'should redirect to root on save' do
      response.should redirect_to(root_path)
    end

  end

  describe 'post to create with invalid story info' do

    before(:each) do
      @battle = Factory.create(:battle)
      post :create, :battle_id => @battle.to_param, :story => { 
        :title => "Thoughts on a Fight",
        :story_text => "Koira should win. That is all."
      }
    end

    it 'should not save info' do
      Story.last.should be_nil
    end

    it 'should render new' do
      response.should render_template(:new)
    end

  end

  describe 'get show' do

    before(:each) do
      @battle = Factory.create(:battle)
      @user = Factory.create(:user)
      post :create, :battle_id => @battle.to_param, :story => { 
        :user_id => @user.to_param, :title => "Thoughts on a Fight",
        :story_text => "Koira should win. That is all."
      }
    end

    it 'should assign correct story to @story' do
      assigns(:story).should eq(Story.last)
    end

    it 'should redirect to correct story page' do
      redirect_to story_path(Story.last)
    end

  end

  describe 'get index' do

    before(:each) do
      @story1 = Factory.create(:story)
      @story2 = Factory.create(:story, :title => "Fights on a Thought",
        :story_text => "All that is, should wind Koira"
      )
      get :index 
    end

    it 'should assign all storys to @stories ordered last to first' do
      assigns(:stories).should eq(Story.all.reverse)
    end

    it 'should redirect to stories index' do
      redirect_to stories_path(@stories)
    end

  end

  describe 'get edit' do

    before(:each) do
      @story = Factory.create(:story)
      get :edit, :id => @story.to_param
    end

    it 'should assign correct story to @story' do
      assigns(:story).should eq(Story.last)
    end

  end

  describe 'post to update with valid story info' do

    before(:each) do
      @story = Factory.create(:story)
      put :update, :id => @story.to_param, :story => { :title => "Feathers" }
    end

    it 'should assign correct story to @story' do
      assigns(:story).should eq(@story)
    end

    it 'should update with correct information' do
      @story.reload
      @story.title.should eq("Feathers")
    end

    it 'should redirect to root path' do
      redirect_to root_path
    end

  end

  describe 'post to update with invalid story info' do

    before(:each) do
      @story = Factory.create(:story)
      put :update, :id => @story.to_param, :story => { :user_id => @not.to_param }
    end

    it 'should assign correct story to @story' do
      assigns(:story).should eq(@story)
    end

    it 'should not alter story info' do
      @story.user.username.should eq("eilif")
    end

    it 'should render edit' do
      response.should render_template(:edit)
    end

  end

  describe 'delete to destroy' do

    before(:each) do
      @story = Factory.create(:story)
      @story2 = Factory.create(:story, :title => "Feathers")
      delete :destroy, :id => @story.to_param
    end

    it 'should assign correct story to @story' do
      assigns(:story).should eq(@story)
    end

    it 'should destroy the correct story' do
      Story.find_by_title("Thoughts on a Fight").should be_nil
      @story2.should be
    end 

    it 'should redirect to root path' do
      redirect_to root_path
    end

  end

end
