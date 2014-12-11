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
  validate :username_not_invalid, :on => [ :update ]

  POINTS = {
    vote_created: 5
  }

  def self.invite_from_spreadsheet(file, dispute)
    CSV.foreach(file.path, headers: true) do |row|
      user = User.find_or_initialize_by(email: row["email"])
      temp_pw = nil
      if !user.persisted?
        temp_pw = SecureRandom.hex(5)
        user.password = temp_pw
        user.role = 'arbitrator'
        user.save
      end
      AdminMailer.delay.invite_arbitrator(user, dispute, temp_pw)
      DisputeUser.create(user: user, dispute: dispute)
    end
  end

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

    def username_not_invalid
      # need better validation so that it's only alphanumeric numbers
      errors.add(:username, "is an invalid username") if ['sign_in', 'sign_up'].include?(username) || username.include?('.') || username.include?('/')
    end
end
