class BattlesController < ApplicationController

  def new
    @battle = Battle.new
  end

  def create
    @battle = Battle.new(params[:battle])
    if @battle.save
      redirect_to root_path
    else
#      render :action => :new
    end
  end

#  def index
#    @battles = Battle.all
#  end

#  def show
#    @battle = Battle.find(params[:id])
#  end

#  def edit
#  end

#  def update
#  end

#  def destroy
#  end

end
