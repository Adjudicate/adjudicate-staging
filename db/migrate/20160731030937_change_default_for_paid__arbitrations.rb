class ChangeDefaultForPaidArbitrations < ActiveRecord::Migration
  def change
  	  	change_column_default :arbitrations, :paid_yet, true
  end
end
