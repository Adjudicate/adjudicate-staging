class ArbitrationsController < ApplicationController
  before_action :authenticate_user!



  def index
    if current_user.admin? || current_user.case_manager?
      @cases = Arbitration.all
    else
      @cases = Arbitration.joins(:arbitration_users).where(arbitration_users: { user_id: current_user.id})
    end
  end


  def new
    @the_case = Arbitration.new
    @the_case.document = params[:document]

  end

  def create
    @the_case = Arbitration.new(arbitration_params)
    @the_case.users << current_user
    uploader = DocumentUploader.new
    uploader.store!(params[:document])
   

    # for user associations
    # @dispute.users << current_user

    if @the_case.save
      redirect_to arbitration_path(@the_case, uid: @the_case.uid)
    end
  end

  
  def show
    @the_case = Arbitration.find(params[:id])
    
  
    # use for associating later??
    # @disputant = params[:uid] == @dispute.uid ? true : false 
    # redirect_to root_path unless [@dispute.uid, @dispute.defendant_uid].include?(params[:uid])
  end

  def edit
      if current_user.admin? || current_user.case_manager?
       @the_case = Arbitration.find(params[:id])
     else
      redirect_to arbitrations_path
     end
  end

  def update
    @the_case = Arbitration.find(params[:id])
    @the_case.update_attributes(arbitration_params)
    @the_case.save
    # redirect_to arbitration_path(@the_case) 
    redirect_to arbitrations_path
  end


  def arbitration_params
      params.require(:arbitration).permit( :creator_name, :creator_email, :defendant_name, :defendant_email, :plaintiff_counsel, :plaintiff_counsel_email, :defendant_counsel, :defendant_counsel_email, :case_summary, :document)
  end


end
