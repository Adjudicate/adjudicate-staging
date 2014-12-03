# class AdminsController < ApplicationController
#   before_action :authenticate_user!
  
#   def show
#     get_admin
#   end

#   def invite_arbitrator
#     AdminMailer.delay.invite_arbitrator(params)
#     redirect_to admin_path(get_admin.username)
#   end

#   private

#     def get_admin
#       #Todo: change to current user
#       @admin = User.where(role: 'admin', username: params[:id]).first
#     end
# end