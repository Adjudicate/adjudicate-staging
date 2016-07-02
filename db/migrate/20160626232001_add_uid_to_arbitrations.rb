class AddUidToArbitrations < ActiveRecord::Migration
  def change
  	add_column :arbitrations, :uid, :string

  end
end
