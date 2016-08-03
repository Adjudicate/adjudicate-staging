class RenameColumnInArbitrations < ActiveRecord::Migration
  def change
  	rename_column :arbitrations, :payable, :amount_payable

  end
end
