class RemoveDefendantUidFromArbitration < ActiveRecord::Migration
  def change
  	remove_column :arbitrations, :defendant_uid, :string
  end
end
