class ArbitrationUser < ActiveRecord::Base
  belongs_to :arbitration
  belongs_to :user
end
