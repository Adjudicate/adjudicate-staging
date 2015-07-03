class CommentsController < ApplicationController
	def create
		comment = Comment.new(comment_params.merge({user_id: current_user.id, dispute_id: params[:dispute_id]}))
		if comment.save!
			flash[:notice] = "Comment submitted successfully!"
		else
			flash[:notice] = "Comment was not saved, please try again."
		end
		redirect_to :back
	end

	private

	def comment_params
		params.require(:comment).permit(:body)
	end
end