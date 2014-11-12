class Vote < ActiveRecord::Base
  validates :survey_id, :uniqueness => {:scope => :user_id, :message => "can only be voted on once" }
  validate :survey_not_expired

  belongs_to :user
  belongs_to :survey

  after_create :add_user_points

  def survey_not_expired
    if self.survey.ended?
      errors.add(:survey, "has ended")
    end
  end

  private

    def add_user_points
      self.user.add_points(:vote_created)
    end
end