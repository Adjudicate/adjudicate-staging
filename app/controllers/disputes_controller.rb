class DisputesController < ApplicationController
  before_action :authenticate_user!, only: [:index, :invite_users, :vote_show]

  def index
    if current_user.admin?
      @disputes = Dispute.all
    else
      @disputes = Dispute.joins(:dispute_users).where(dispute_users: { user_id: current_user.id})
    end
    @disputes.includes(:survey)
  end

  def show
    @dispute = Dispute.find(params[:id])
    gon.votes = @dispute.survey.votes
    p gon
    redirect_to root_path unless [@dispute.uid, @dispute.defendant_uid].include?(params[:uid])
  end

  def vote_show
    @dispute = current_user.admin? ? Dispute.find(params[:dispute_id]) : Dispute.joins(:dispute_users).where(disputes: {id: params[:dispute_id] }, dispute_users: { user_id: current_user.id}).first
    if @dispute
      @vote = Vote.where(survey_id: @dispute.survey.id, user_id: current_user.id).first || Vote.new
    else
      redirect_to root_path
    end
  end

  def edit
    @dispute = Dispute.find(params[:id])
    if [@dispute.uid, @dispute.defendant_uid].include?(params[:uid])
      @disputant = params[:uid] == @dispute.uid ? true : false
    else
      redirect_to root_path
    end
  end

  def update
    @dispute = Dispute.find(params[:id])
    if @dispute.update_attributes(dispute_params)
      redirect_to dispute_path(@dispute, uid: @dispute.uid)
    else
      redirect_to edit_dispute_path(@dispute)
    end
  end

  def new
    @dispute = Dispute.new
  end

  def create
    @dispute = Dispute.new(dispute_params)
    @dispute.users << current_user

    if @dispute.save
      redirect_to edit_dispute_path(@dispute, uid: @dispute.uid)
    else
      # TODO: better redirect
      redirect_to new_dispute_path
    end
  end

  def destroy
  end

  def invite_users
    @dispute = Dispute.find(params[:id])
    emails = params[:email].split(',').each do |email|
      @user = User.find_or_initialize_by(email: email)
      @temp_pw = nil
      if !@user.persisted?
        @temp_pw = SecureRandom.hex(5)
        @user.password = @temp_pw
        @user.save
      end
      AdminMailer.delay.invite_arbitrator(@user, @temp_pw)
      DisputeUser.create(user: @user, dispute: @dispute)
    end
  end

  private

    def dispute_params
      params.require(:dispute).permit(:url, :violating_content, :reason, :creator_email, :violator_contact)
    end

end