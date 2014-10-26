class DisputesController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def show
    @dispute = Dispute.find(params[:id])
  end

  def edit
    @dispute = Dispute.find(params[:id])
  end

  def update
    @dispute = Dispute.find(params[:id])
    if @dispute.update_attributes(dispute_params)
      redirect_to dispute_path(@dispute)
    else
      redirect_to edit_dispute_path(@dispute)
    end
  end

  def new
    @dispute = Dispute.new
  end

  def create
    @dispute = Dispute.new(dispute_params)

    if @dispute.save
      redirect_to edit_dispute_path(@dispute)
    else
      # TODO: better redirect
      redirect_to new_dispute_path
    end
  end

  def destroy
  end

  private

    def dispute_params
      params.require(:dispute).permit(:url, :violating_content, :reason)
    end

end