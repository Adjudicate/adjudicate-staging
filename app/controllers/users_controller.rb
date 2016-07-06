class UsersController < ApplicationController
  before_action :authenticate_user!

  def new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to root_path
    else
      redirect "/"
    end
  end

  def show
    @disputes = disputes
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
      User.invite_from_list(params[:invitations].split(","), dispute)
      redirect_to user_path(current_user), :flash => { :notice => 'Invitation Successful.'}
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

  def disputes
    dispute_presenters = get_user.admin? ? Dispute.all : get_user.disputes
    dispute_presenters.map{|dispute| DisputePresenter.new(dispute).form_data}
  end

  private

  def get_user
    @user = User.find_by_username(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :email, :password, :role)
  end
end