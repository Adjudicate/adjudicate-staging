class AddViolaterContactToDispute < ActiveRecord::Migration
  def change
    add_column :disputes, :violator_contact, :string
  end
end
