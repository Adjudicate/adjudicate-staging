class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    user = get_user
    @disputes = user.disputes.map{|dispute| DisputePresenter.new(dispute).form_data}.unshift('')
    # Adding a blank element to the beginning of the array allows the placeholder text to show up. 
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
    dispute = Dispute.find_by_uid(params[:uid])
    if current_user.admin? && dispute
      User.invite_from_list(params[:invitations], dispute)
      redirect_to user_path(current_user), :flash => { :notice => 'You have successfully invited arbitrators.'}
    else
      redirect_to user_path(current_user), :flash => { :error => 'Errors: You must choose a dispute and enter arbitrators.'}
    end
  end

  def inform_defendant
    dispute = Dispute.find_by_uid(params[:defendant_uid])
    if current_user.admin? && dispute
      defendant_email = dispute.violator_contact
      AdminMailer.delay.inform_defendant(defendant_email, dispute)
      redirect_to user_path(current_user), :flash => { :notice => "#{defendant_email} has been informed."}
    else
      redirect_to user_path(current_user), :flash => { :error => 'Errors: entered in wrong dispute UID'}
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