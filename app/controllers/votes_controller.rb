class VotesController < ApplicationController

  def create
    @battle = Battle.find(params[:battle_id])
    @battle.vote_for(params[:animal_id])
    redirect_to battle_path(@battle)
  end

end
