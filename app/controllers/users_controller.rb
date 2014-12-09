class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    get_user
  end

  def edit
    get_user
  end

  def update
    get_user
    if @user.update_attributes(user_params)
      render 'show'
    else
      #TODO: implement friendly redirects
      redirect_to edit_user_path(@user), :flash => { :error => @user.errors.full_messages }
    end
  end

  def invite_arbitrator
    dispute = Dispute.find_by_uid(params[:uid])
    User.invite_from_spreadsheet(params[:file], dispute) if current_user.admin? && dispute
    redirect_to user_path(current_user), :flash => { :notice => 'You have successfully invited arbitrators.'}
  end



  private

    def get_user
      @user = User.find_by_username(params[:id])
    end

    def user_params
      params.require(:user).permit(:username, :email, :password)
    end
end