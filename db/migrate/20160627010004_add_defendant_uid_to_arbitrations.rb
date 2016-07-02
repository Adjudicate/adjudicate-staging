class AddDefendantUidToArbitrations < ActiveRecord::Migration
  def change
  	add_column :arbitrations, :defendant_uid, :string
  end
end
