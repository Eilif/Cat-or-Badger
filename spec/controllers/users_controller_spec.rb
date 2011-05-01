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
      @test_image = Rails.root + "spec/fixtures/images/seagull.jpg"
      @file = Rack::Test::UploadedFile.new(@test_image, "image/jpeg")
      post :create, :user => { :username => "Tan-ky_a11.chara",
      :email => "valid@format.net", :image => @file,
      :bio => "Lots of text that I don't want to write",
      :signature_quote => "I feel empty." }
    end

    it 'should assign user to @user' do
      assigns(:user).should eq(User.last)
    end

    it 'should create user with correct info' do
      User.last.username.should eq("Tan-ky_a11.chara")
      User.last.email.should eq("valid@format.net")
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
      @test_image = Rails.root + "spec/fixtures/images/seagull.jpg"
      @file = Rack::Test::UploadedFile.new(@test_image, "image/jpeg")
      @u = User.create!(:username => "Tan-ky_a11.chara",
      :email => "valid@format.net", :image => @file,
      :bio => "Lots of text that I don't want to write",
      :signature_quote => "I feel empty.")
      get :show, :id => @u.to_param
    end

    it 'should assign correct user to @user' do
      assigns(:user).email.should eq("valid@format.net")
    end

    it 'should redirect to correct user page' do
      redirect_to user_path(User.last)
    end

  end

  describe 'get edit' do

    before (:each) do
      @test_image = Rails.root + "spec/fixtures/images/seagull.jpg"
      @file = Rack::Test::UploadedFile.new(@test_image, "image/jpeg")
      @u = User.create!(:username => "Tan-ky_a11.chara",
      :email => "valid@format.net", :image => @file,
      :bio => "Lots of text that I don't want to write",
      :signature_quote => "I feel empty.")
      get :edit, :id => @u.to_param
    end

    it 'should assign correct user to @user' do
      assigns(:user).should eq(@u)
    end

  end

  describe 'post to update with valid user info' do

    before (:each) do
      @test_image = Rails.root + "spec/fixtures/images/seagull.jpg"
      @file = Rack::Test::UploadedFile.new(@test_image, "image/jpeg")
      @u = User.create!(:username => "Tan-ky_a11.chara",
      :email => "valid@format.net", :image => @file,
      :bio => "Lots of text that I don't want to write",
      :signature_quote => "I feel empty.")
      put :update, :id => @u.to_param, :user => { :email => "switched@flaky.com" }
    end

    it 'should assign correct user to @user' do
      assigns(:user).should eq(@u)
    end

    it 'should save correct info' do
      User.last.email.should eq("switched@flaky.com")
    end

    it 'should redirect to user show' do
      redirect_to user_path(@u)
    end

  end

  describe 'post to update with invalid user info' do

    before (:each) do
      @test_image = Rails.root + "spec/fixtures/images/seagull.jpg"
      @file = Rack::Test::UploadedFile.new(@test_image, "image/jpeg")
      @u = User.create!(:username => "Tan-ky_a11.chara",
      :email => "valid@format.net", :image => @file,
      :bio => "Lots of text that I don't want to write",
      :signature_quote => "I feel empty.")
      put :update, :id => @u.to_param, :user => { :email => "switched@flaky.com",
      :username => "" }
    end

    it 'should assign correct user to @user' do
      assigns(:user).should eq(@u)
    end

    it 'should not change user info' do
      User.last.username.should eq("Tan-ky_a11.chara")
      User.last.email.should eq("valid@format.net")
    end

    it 'should render edit' do
      response.should render_template(:edit)
    end

  end

  describe 'delete destroy' do

    before (:each) do
      @test_image = Rails.root + "spec/fixtures/images/seagull.jpg"
      @file = Rack::Test::UploadedFile.new(@test_image, "image/jpeg")
      @u1 = User.create!(:username => "Alexis",
      :email => "narm@format.net", :image => @file,
      :bio => "Lots of text that I don't want to write",
      :signature_quote => "I feel empty.")
      @u = User.create!(:username => "Tan-ky_a11.chara",
      :email => "valid@format.net", :image => @file,
      :bio => "Lots of text that I don't want to write",
      :signature_quote => "I feel empty.")
      delete :destroy, :id => @u.to_param
    end

    it 'should assign user to @user' do
      assigns(:user).should eq(@u)
    end

    it 'should destroy the correct user' do
      User.find_by_id(@u.id).should be_nil
      @u1.reload.username.should eq("Alexis")
    end

    it 'should redirect to root path' do
      redirect_to root_path
    end

  end

  describe 'get index' do

    before (:each) do
      @test_image = Rails.root + "spec/fixtures/images/seagull.jpg"
      @file = Rack::Test::UploadedFile.new(@test_image, "image/jpeg")
      @u1 = User.create!(:username => "Alexis",
      :email => "narm@format.net", :image => @file,
      :bio => "Lots of text that I don't want to write",
      :signature_quote => "I feel empty.")
      @u = User.create!(:username => "Tan-ky_a11.chara",
      :email => "valid@format.net", :image => @file,
      :bio => "Lots of text that I don't want to write",
      :signature_quote => "I feel empty.")
      get :index
    end

    it 'should assign all users to @user' do
      assigns(:users).should eq(User.all)
    end

  end

end
