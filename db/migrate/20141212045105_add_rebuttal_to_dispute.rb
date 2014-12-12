class AddRebuttalToDispute < ActiveRecord::Migration
  def change
    add_column :disputes, :rebuttal, :text
  end
end
