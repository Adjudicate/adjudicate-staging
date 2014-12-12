class AddDefendantUidToDispute < ActiveRecord::Migration
  def change
    add_column :disputes, :defendant_uid, :string
    Dispute.all.each do |d|
      d.update_column('defendant_uid', SecureRandom.hex(10))
    end
  end
end
