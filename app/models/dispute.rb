class Dispute < ActiveRecord::Base
  has_many :dispute_documents, dependent: :destroy
  has_one :survey
  belongs_to :creator, class_name: 'User', foreign_key: :creator_id

  after_create :after_create_methods

  def after_create_methods
    attach_survey
    AdminMailer.delay.dispute_submitted(self)
  end

  def attach_survey
    self.survey = Survey.attach_default(self.id)
  end

end