class ChangeSomeDefaultsInArbitrations < ActiveRecord::Migration
  def change
  	change_column_default :arbitrations, :defendant_name, ""
  	change_column_default :arbitrations, :defendant_counsel_email, ""
  	change_column_default :arbitrations, :defendant_email, ""
  	change_column_default :arbitrations, :defendant_counsel, ""
  end
end
