class MakeDefaultForArbitrations < ActiveRecord::Migration
  def change
  	change_column_default :arbitrations, :defendant_name, "unknown"
  	change_column_default :arbitrations, :plaintiff_counsel, ""
  	change_column_default :arbitrations, :defendant_counsel_email, "unknown"
  	change_column_default :arbitrations, :plaintiff_counsel_email, ""
  	change_column_default :arbitrations, :defendant_email, "unknown"
  	change_column_default :arbitrations, :defendant_counsel, "unknown"
  end
end




