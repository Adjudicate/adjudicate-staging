class CreateVotes < ActiveRecord::Migration
  def change
    create_table :surveys do |t|
      t.references :dispute, null: false
      t.datetime :deadline, null: false
      t.boolean :takedown_result
    end

    create_table :votes do |t|
      t.references :user, null: false
      t.references :survey, null: false
      t.boolean :takedown, null: false
    end
  end
end
