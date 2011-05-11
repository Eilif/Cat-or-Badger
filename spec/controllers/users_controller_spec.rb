require 'spec_helper'

describe UsersController do

  describe 'get new' do

    it 'should assign user to @user' do
      get :new
      assigns(:user).should be
    end

  end

  describe 'post to create with valid user info' do

    before (:each) do
      @user = Factory.build(:user)
      post :create, :user => @user.attributes
    end

    it 'should assign user to @user' do
      assigns(:user).should eq(User.last)
    end

    it 'should create user with correct info' do
      User.last.username.should eq("eilif")
      User.last.email.should eq("eilif@email.org")
      User.last.image.original_filename.should eq("seagull.jpg")
      User.last.bio.should eq("Lots of text that I don't want to write")
      User.last.signature_quote.should eq("I feel empty.")
    end

    it 'should redirect to user show page' do
      redirect_to user_path(User.last)
    end

  end

  describe 'post to create with invalid user info' do

    before(:each) do
      post :create, :user => { :username => "", :email => "" }
    end

    it 'should not create user' do
      User.last.should eq(nil)
    end

    it 'should render new' do
      response.should render_template(:new)
    end

  end

  describe 'get show' do

    before (:each) do
      @user = Factory.create(:user)
      get :show, :id => @user.to_param
    end

    it 'should assign correct user to @user' do
      assigns(:user).email.should eq("eilif@email.org")
    end

    it 'should redirect to correct user page' do
      redirect_to user_path(User.last)
    end

  end

  describe 'get edit' do

    before (:each) do
      @user = Factory.create(:user)
      get :edit, :id => @user.to_param
    end

    it 'should assign correct user to @user' do
      assigns(:user).should eq(User.last)
    end

  end

  describe 'post to update with valid user info' do

    before (:each) do
      @user = Factory.create(:user)
      put :update, :id => @user.to_param, :user => {
        :email => "switched@flaky.com"
      }
    end

    it 'should assign correct user to @user' do
      assigns(:user).should eq(User.last)
    end

    it 'should save correct info' do
      User.last.email.should eq("switched@flaky.com")
    end

    it 'should redirect to user show' do
      redirect_to user_path(@user)
    end

  end

  describe 'post to update with invalid user info' do

    before (:each) do
      @user = Factory.create(:user)
      put :update, :id => @user.to_param, :user => {
        :email => "switched@flaky.com", :username => ""
      }
    end

    it 'should assign correct user to @user' do
      assigns(:user).should eq(User.last)
    end

    it 'should not change user info' do
      User.last.username.should eq("eilif")
      User.last.email.should eq("eilif@email.org")
    end

    it 'should render edit' do
      response.should render_template(:edit)
    end

  end

  describe 'delete destroy' do

    before (:each) do
      @user = Factory.create(:user)
      @user2 = Factory.create(:user, :username => "Alexis")
      delete :destroy, :id => @user.to_param
    end

    it 'should assign user to @user' do
      assigns(:user).username.should eq("eilif")
    end

    it 'should destroy the correct user' do
      User.find_by_username("eilif").should be_nil
      @user2.reload.username.should eq("Alexis")
    end

    it 'should redirect to root path' do
      redirect_to root_path
    end

  end

  describe 'get index' do

    before (:each) do
      @user = Factory.create(:user)
      @user2 = Factory.create(:user, :username => "Alexis")
      get :index
    end

    it 'should assign all users to @user' do
      assigns(:users).should eq(User.all)
    end

  end

end
