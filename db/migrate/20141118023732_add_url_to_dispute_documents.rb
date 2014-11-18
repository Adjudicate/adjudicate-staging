class AddUrlToDisputeDocuments < ActiveRecord::Migration
  def change
    add_column :dispute_documents, :s3_url, :string
  end
end
