class ChangeSummaryInArbitrations < ActiveRecord::Migration
  def change
  	  change_column :arbitrations, :case_summary, :text

  end
end
