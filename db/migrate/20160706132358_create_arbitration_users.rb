class CreateArbitrationUsers < ActiveRecord::Migration
  def change
    create_table :arbitration_users do |t|
      t.integer :user_id
      t.integer :arbitration_id

      t.timestamps
    end
  end
end
