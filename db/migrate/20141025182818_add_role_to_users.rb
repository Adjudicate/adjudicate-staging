class AddRoleToUsers < ActiveRecord::Migration
  def change
    add_column :users, :role, :string
    add_column :users, :points, :integer
  end
end
