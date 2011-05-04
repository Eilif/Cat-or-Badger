class VotesController < ApplicationController

  def new
    @vote = Vote.new
  end

  def create
    @vote = Vote.new(params[:vote])
    if @vote.save
      redirect_to root_path
    else
      redirect_to root_path
      flash[:message] = "You don't count! Sorry, something went wrong and we didn't receive your vote. Head over to the contact page, send me an e-mail, and I'll see what I can do to fix it."
    end
  end 

#  def create
#    @battle = Battle.find(params[:battle_id])
#    @battle.vote_for(params[:animal_id])
#    redirect_to battle_path(@battle)
#  end

end
