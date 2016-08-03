class ChangePaidYetInArbitrations < ActiveRecord::Migration
  def change
  	rename_column :arbitrations, :paid_yet, :payment_due

  end
end
