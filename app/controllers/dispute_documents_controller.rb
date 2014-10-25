class DisputeDocumentsController < ApplicationController

  def index
  end

  def create
    @dispute_document = DisputeDocument.new(dispute_params)
    @dispute_document.dispute_id = params[:dispute_id]
    if @dispute_document.save
    else
      Rails.logger.info(@dispute_document.errors.inspect) 
    end
  end

  def destroy
  end

  private
    def dispute_params
      params.require(:dispute_document).permit(:direct_upload_url)
    end
end