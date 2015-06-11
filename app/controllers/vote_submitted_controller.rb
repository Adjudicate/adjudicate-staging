class VoteSubmittedController < ApplicationController
	
	def index
		@dispute = Dispute.find(params[:dispute_id])
	end
end