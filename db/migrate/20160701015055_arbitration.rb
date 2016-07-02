class Arbitration < ActiveRecord::Migration
  def change
  	add_column :arbitrations, :document, :string
  end
end
