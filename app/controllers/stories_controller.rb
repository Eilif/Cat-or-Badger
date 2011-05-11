class StoriesController < ApplicationController

  def new
    @story = Story.new
  end

  def create
    @battle = Battle.find(params[:battle_id])
    @story = @battle.stories.build(params[:story])
    if @story.save
      redirect_to root_path
    else
      render :action => :new
    end
  end

  def show
    @story = Story.find(params[:id])
  end

  def index
    @stories = Story.all :order => 'id DESC'
  end

  def edit
    @story = Story.find(params[:id])
  end

  def update
    @story = Story.find(params[:id])
    @story.attributes = params[:story]
    if @story.save
      redirect_to root_path
    else
      render :action => :edit
    end
  end

  def destroy
    @story = Story.find(params[:id])
    @story.destroy
    redirect_to root_path
  end

end
