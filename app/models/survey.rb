class Survey < ActiveRecord::Base
  belongs_to :dispute
  has_many :votes

  def self.attach_default(dispute_id)
    Survey.create(dispute_id: dispute_id, deadline: 1.month.from_now)
  end
end