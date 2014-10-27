class AddCreatorIdToUsers < ActiveRecord::Migration
  def change
    add_column :disputes, :creator_id, :integer, null: false
  end
end
