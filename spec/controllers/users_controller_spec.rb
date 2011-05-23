require 'spec_helper'

describe UsersController do

  describe 'get show' do

    before (:each) do
      @user = Factory.create(:user)
      get :show, :id => @user.to_param
    end

    it 'should assign correct user to @user' do
      assigns(:user).should eq(@user)
    end

    it 'should redirect to correct user page' do
      redirect_to user_path(User.last)
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
