class CreateDisputeDocuments < ActiveRecord::Migration
  def change
    create_table :dispute_documents do |t|
      t.integer :dispute_id, null: false
      t.string :direct_upload_url, null: false
      t.attachment :upload
      t.boolean :processed, default: false, null: false
      t.timestamps
    end
    add_index :dispute_documents, :dispute_id
    add_index :dispute_documents, :processed
  end
end
