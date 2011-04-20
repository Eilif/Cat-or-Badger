class BattlesController < ApplicationController

  def new
    @battle = Battle.new
  end

  def create
    @battle = Battle.new(params[:battle])
    if @battle.save
      redirect_to root_path
    else
      render :action => :new
    end
  end

  def index
    @battles = Battle.all :order => 'id DESC'
  end

  def show
    @battle = Battle.find(params[:id])
  end

  def edit
    @battle = Battle.find(params[:id])
  end

  def update
    @battle = Battle.find(params[:id])
    @battle.attributes = params[:battle]
    if @battle.save
      redirect_to root_path
    else
      render :action => :edit
    end
  end

  def destroy
    @battle = Battle.find(params[:id])
    @battle.destroy
    redirect_to root_path
  end

end
