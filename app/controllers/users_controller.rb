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
    params[:user].delete(:password) if params[:user][:password].blank?
    if @user.update_attributes(user_params)
      redirect_to user_path(@user)
    else
      #TODO: implement friendly redirects
      p @user
      redirect_to edit_user_path(@user.username_was), :flash => { :error => @user.errors.full_messages }
    end
  end

  def invite_arbitrator
    p params[:file]
    dispute = Dispute.find_by_uid(params[:uid])
    if current_user.admin? && dispute
      User.invite_from_spreadsheet(params[:file], dispute)
      redirect_to user_path(current_user), :flash => { :notice => 'You have successfully invited arbitrators.'}
    else
      redirect_to user_path(current_user), :flash => { :error => 'Errors: Need valid CSV and correct UID'}
    end
  end



  private

    def get_user
      @user = User.find_by_username(params[:id])
    end

    def user_params
      params.require(:user).permit(:username, :email, :password)
    end
end