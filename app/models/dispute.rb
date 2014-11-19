class Dispute < ActiveRecord::Base
  has_many :dispute_documents, dependent: :destroy
  has_many :dispute_users
  has_many :users, through: :dispute_users
  has_one :survey

  after_create :after_create_methods

  validates_presence_of :creator_email
  validates_presence_of :url

  def after_create_methods
    attach_survey
    AdminMailer.delay.dispute_submitted(self)
    AdminMailer.delay.send_confirmation_email(self)
  end

  def attach_survey
    self.survey = Survey.attach_default(self.id)
  end

end