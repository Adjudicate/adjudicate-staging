class DisputePresenter 
	attr_reader :dispute

	def initialize(dispute)
		@dispute = dispute
	end

	def form_data
		["#{dispute.creator_email} v. #{dispute.violator_contact} - #{dispute.uid}", dispute.uid]
	end
end