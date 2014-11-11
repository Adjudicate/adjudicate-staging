class VotesController < ApplicationController
  def create
    dispute = Dispute.find(params[:dispute_id])
    @vote = Vote.new(vote_params)
    @vote.user = current_user
    @vote.survey = dispute.survey
    if @vote.save
      redirect_to disputes_path
    else

    end
  end

  private
    def vote_params
      params.require(:vote).permit(:takedown)
    end
end