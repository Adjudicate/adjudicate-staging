class AddNameToDispute < ActiveRecord::Migration
  def change
  	add_column :disputes, :creator_name, :string
  	add_column :disputes, :defendant_name, :string
  end
end
