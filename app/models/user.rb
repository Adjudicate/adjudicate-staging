class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  after_create :create_default_username

  validates_presence_of :email
  validates_uniqueness_of :email

  def to_param
    username
  end

  def admin?
    self.role == 'admin'
  end

  def create_default_username
    username = "#{self.role}#{1000 + self.id}"
    self.update_column('username', username)
  end
end
