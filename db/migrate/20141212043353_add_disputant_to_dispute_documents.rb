class AddDisputantToDisputeDocuments < ActiveRecord::Migration
  def change
    add_column :dispute_documents, :disputant, :boolean, default: true
    DisputeDocument.all.each do |dd|
      dd.update_column('disputant', false)
    end
  end
end
