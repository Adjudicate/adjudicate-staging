class Comment < ActiveRecord::Base
	belongs_to :user
	belongs_to :dispute

	def author
		user.email
	end
end