class Arbitration < ActiveRecord::Base
  mount_uploader :document, DocumentUploader
 


  # validates_presence_of :creator_email
  # validates_presence_of :url
  # validates_presence_of :violator_contact

  # has_attached_file :upload

  before_create :create_uids
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
