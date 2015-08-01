class Dispute < ActiveRecord::Base
  has_many :dispute_documents, dependent: :destroy
  has_many :dispute_users
  has_many :users, through: :dispute_users
  has_many :comments
  has_one :survey

  before_create :create_uids
  after_create :after_create_methods

  validates_presence_of :creator_email
  validates_presence_of :url
  validates_presence_of :violator_contact

  def after_create_methods
    attach_survey
    AdminMailer.delay.dispute_submitted(self)
    AdminMailer.delay.send_confirmation_email(self)
    assign_to_admins
  end

  def attach_survey
    self.survey = Survey.attach_default(self.id)
  end

  def create_uids
    self.uid = SecureRandom.hex(10)
    self.defendant_uid = SecureRandom.hex(10)
  end

  def assign_to_admins
    User.admins.includes(:disputes).each do |a| 
      a.disputes << self if !a.disputes.include?(self)
      a.save
    end
  end

end