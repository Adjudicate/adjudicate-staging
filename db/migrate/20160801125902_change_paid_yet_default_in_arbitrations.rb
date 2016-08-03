class ChangePaidYetDefaultInArbitrations < ActiveRecord::Migration
  def change
  	change_column_default :arbitrations, :payment_due, false

  end
end
