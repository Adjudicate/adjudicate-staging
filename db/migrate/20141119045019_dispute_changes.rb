class DisputeChanges < ActiveRecord::Migration
  def change
    remove_column :disputes, :creator_id
    add_column :disputes, :creator_email, :string
  end
end
