class CreateDisputesUsers < ActiveRecord::Migration
  def change
    create_table :dispute_users do |t|
      t.references :user
      t.references :dispute
      t.boolean :voted, default: false

      t.timestamps
    end
  end
end
