class MakeDefaultForPayable < ActiveRecord::Migration
  def change
  	change_column_default :arbitrations, :paid_yet, false
  	change_column_default :arbitrations, :amount_payable, 0

  end
end
