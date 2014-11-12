class Dispute < ActiveRecord::Base
  has_many :dispute_documents
  has_one :survey
  belongs_to :creator, class_name: 'User', foreign_key: :creator_id

  after_create :attach_survey

  def attach_survey
    self.survey = Survey.attach_default(self.id)
  end

end