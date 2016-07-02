class Arbitrations < ActiveRecord::Migration
  def change
  	add_column :arbitrations, :creator_name, :string
  	add_column :arbitrations, :defendant_name, :string
  	add_column :arbitrations, :plaintiff_counsel, :string
  	add_column :arbitrations, :defendant_counsel, :string
  	add_column :arbitrations, :creator_email, :string
  	add_column :arbitrations, :defendant_email, :string
  	add_column :arbitrations, :plaintiff_counsel_email, :string
  	add_column :arbitrations, :defendant_counsel_email, :string
  	add_column :arbitrations, :case_summary, :string
  	# add_column :arbitrations, :defendant_name, :string
  end
end
