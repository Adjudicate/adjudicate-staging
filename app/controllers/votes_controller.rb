class VotesController < ApplicationController
  def create
    dispute = Dispute.find(params[:dispute_id])
    @vote = Vote.new(vote_params)
    @vote.user = current_user
    @vote.survey = dispute.survey
    if @vote.save!
      redirect_to dispute_vote_submitted_index_path
    else
      flash[:notice] = 'Vote was not processed, try again.'
      redirect_to :back
    end
  end

  def edit
    dispute = Dispute.find(params[:dispute_id])
    @vote = Vote.where(user_id: current_user.id, survey_id: dispute.survey.id).first
    if @vote.update_attributes(vote_params)
      redirect_to dispute_vote_submitted_index_path
    else
      flash[:notice] = 'Vote was not processed, try again.'
      redirect_to :back
    end
  end

  private
    def vote_params
      params.require(:vote).permit(:takedown)
    end
end