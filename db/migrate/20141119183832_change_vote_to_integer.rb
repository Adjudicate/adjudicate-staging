class ChangeVoteToInteger < ActiveRecord::Migration
  def change
    remove_column :votes, :takedown
    add_column :votes, :takedown, :integer  
  end
end
