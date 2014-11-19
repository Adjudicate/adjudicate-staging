class AddUidToDispute < ActiveRecord::Migration
  def change
    add_column :disputes, :uid, :string
  end
end
