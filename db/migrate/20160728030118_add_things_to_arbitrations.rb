class AddThingsToArbitrations < ActiveRecord::Migration
  def change
    add_column :arbitrations, :payable, :integer
    add_column :arbitrations, :paid_yet, :boolean
  end
end
