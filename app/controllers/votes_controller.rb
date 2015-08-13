class VotesController < ApplicationController
  def create
    @vote = Vote.new(vote_params)
    @vote.user = current_user
    @vote.survey = dispute.survey
    @comment = Comment.new(comment_params)
    if @vote.save! && @comment.save!
      redirect_to dispute_vote_submitted_index_path
    else
      flash[:notice] = 'Vote was not processed, try again.'
      redirect_to :back
    end
  end

  def edit
    @vote = Vote.where(user_id: current_user.id, survey_id: dispute.survey.id).first
    @comment = Comment.new(comment_params)
    if @vote.update_attributes!(vote_params) && @comment.save!
      redirect_to dispute_vote_submitted_index_path
    else
      flash[:notice] = 'Vote was not processed, try again.'
      redirect_to :back
    end
  end

  private

  def dispute
    @dispute ||= Dispute.find(params[:dispute_id])
  end

  def vote_params
    params.require(:vote).permit(:takedown)
  end

  def comment_params
    params.require(:vote).require(:comment).permit(:body).merge(dispute_id: @dispute.id, user_id: current_user.id)
  end
end