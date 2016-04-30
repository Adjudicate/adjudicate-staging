class AddCreatedAtToDisputes < ActiveRecord::Migration
  def change
  	add_column :disputes, :created_at, :datetime
  end
end
