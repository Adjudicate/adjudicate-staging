class DisputesController < ApplicationController
  before_action :authenticate_user!

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
    @disputant = params[:uid] == @dispute.uid ? true : false
    gon.votes = @dispute.survey.votes
    @comments = @dispute.comments
    redirect_to root_path unless [@dispute.uid, @dispute.defendant_uid].include?(params[:uid])
  end

  def vote_show
    @dispute = current_user.admin? ? Dispute.find(params[:dispute_id]) : Dispute.joins(:dispute_users).where(disputes: {id: params[:dispute_id] }, dispute_users: { user_id: current_user.id}).first
    if @dispute
      @vote = Vote.where(survey_id: @dispute.survey.id, user_id: current_user.id).first || Vote.new
      @comment = Comment.new
      @comments = @dispute.comments
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

  def edit_admin
    @dispute = Dispute.find(params[:dispute_id])
    @disputant = params[:uid] == @dispute.uid ? true : false
  end

  def update
    @dispute = Dispute.find(params[:id])
    if current_user.admin?
      if @dispute.update_attributes(dispute_params)
        redirect_to dispute_path(@dispute, uid: @dispute.uid)
      else
        redirect_to edit_dispute_path(@dispute)
      end
    else
      if @dispute.update_attributes(dispute_params) && 
         @dispute.save_with_payment
         redirect_to dispute_path(@dispute, uid: @dispute.uid), 
         :notice => "Thank you for using Adjudicate!"
      else
        redirect_to edit_dispute_path(@dispute)
      end
    end
  end

def update_admin
  @dispute = Dispute.find(params[:dispute_id])
    if current_user.admin?
      if @dispute.update_attributes(dispute_params) && @dispute.save
        redirect_to dispute_path(@dispute, uid: @dispute.uid)
      else
        redirect_to edit_dispute_path(@dispute)
      end
   
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
      if current_user.admin?
        redirect_to dispute_edit_admin_url(@dispute, uid: @dispute.uid)
      else
      redirect_to edit_dispute_path(@dispute, uid: @dispute.uid)
      end
    else
      # TODO: better redirect
      redirect_to new_dispute_path
    end
  end

  def destroy
    @dispute = Dispute.find(params[:id])
    @dispute.delete
    redirect_to disputes_path

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
      params.require(:dispute).permit(:url, :violating_content, :reason, :creator_email, :violator_contact, :stripe_card_token, :created_at, :creator_name, :defendant_name)
    end

end