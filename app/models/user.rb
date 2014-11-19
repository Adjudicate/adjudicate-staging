class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :dispute_users
  has_many :disputes, through: :dispute_users

  after_create :after_create_methods

  validates_presence_of :email
  validates_uniqueness_of :email

  POINTS = {
    vote_created: 5
  }

  def to_param
    username
  end

  def admin?
    self.role == 'admin'
  end

  def add_points(key)
    self.increment!(:points, POINTS[key])
  end

  private

    def after_create_methods
      create_default_username
      AdminMailer.delay.new_user_signup(self)
    end

    def create_default_username
      username = "user_#{self.role}#{1000 + self.id}"
      self.update_column('username', username)
    end
end
