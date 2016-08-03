class Arbitration < ActiveRecord::Base
  has_many :arbitration_users
  has_many :users, through: :arbitration_users
  mount_uploader :document, DocumentUploader


  # validates_presence_of :creator_email
  # validates_presence_of :url
  # validates_presence_of :violator_contact

  # has_attached_file :upload

  before_create :create_uids


  attr_accessor :stripe_card_token

    def save_with_payment  
    charge = Stripe::Charge.create(
    :amount => self.amount_payable * 100, # amount in cents
    :currency => "usd",
    :card => stripe_card_token,
    :description => "Payment for Arbitration Services"
    )
    rescue Stripe::CardError => e
      # The card has been declined
  end
  # after_save :save_document, if: :document

  # def save_document
  # 	filename = @original_filename
  # 	# filename = document.original_filename
  # 	folder = "public/arbitrations/#{id}"

  # 	FileUtils::mkdir_p folder

  # 	f = File.open File.join(folder, filename), "wb"
  # 	f.write document.read()
  # 	f.close

  # 	self.document = nil
  # 	update document: filename


  # end

  




 def create_uids
    self.uid = SecureRandom.hex(10)
    # self.manager_uid = SecureRandom.hex(10)
  end





end
