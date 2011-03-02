class AnimalsController < ActionController::Base

  def new
    @animal = Animal.new
  end

  def create
    @animal = Animal.new(params[:animal])
    if @animal.save
      redirect_to root_path
    else
      render :action => :new
    end
  end

#  def destroy
 #   @animal = Animal.find(params[:id])
  #  @animal.destroy
   # redirect_to root_path
#  end

#  def edit
 #   @animal = Animal.find(params[:id])
  #end

#  def update
 #   @animal = Animal.find(params[:id])
  #  @animal.attributes = params[:animal]
   # if @animal.save
    #  redirect_to root_path
#    else
 #     render :action => :edit
  #  end
#  end

  def index
    @animals = Animal.all :order => 'id DESC'
  end

#  def show
 #   @animal = Animal.find(params[:id])
  #end

end
