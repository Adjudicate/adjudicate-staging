class Dispute < ActiveRecord::Base
  has_many :dispute_documents
end