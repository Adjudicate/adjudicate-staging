class DisputeUser < ActiveRecord::Base
  belongs_to :dispute
  belongs_to :user
end