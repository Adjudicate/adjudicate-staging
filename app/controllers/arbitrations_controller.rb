class ArbitrationsController < ApplicationController



  def index
    @cases = Arbitration.all
  end


  def new
    @the_case = Arbitration.new
    @the_case.document = params[:document]

  end

  def create
    @the_case = Arbitration.new(arbitration_params)
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
    @the_case = Arbitration.find(params[:id])
  end

  def update
    @the_case = Arbitration.find(params[:id])
    @the_case.update_attributes(arbitration_params)
    @the_case.save
    # redirect_to arbitration_path(@the_case) 
    redirect_to arbitrations_path
  end


  def arbitration_params
      params.require(:arbitration).permit( :creator_name, :defendant_name, :case_summary, :document)
  end


end
