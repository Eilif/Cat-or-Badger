class UsersController < ApplicationController
  before_filter :authenticate_user!, :only => [ :edit, :update, :destroy ]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

end
