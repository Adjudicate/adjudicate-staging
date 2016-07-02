class CreateArbitrations < ActiveRecord::Migration
  def change
    create_table :arbitrations do |t|

      t.timestamps
    end
  end
end
