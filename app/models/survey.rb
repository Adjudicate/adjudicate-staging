class Survey < ActiveRecord::Base
  belongs_to :dispute
  has_many :votes, dependent: :destroy

  def self.attach_default(dispute_id)
    Survey.create(dispute_id: dispute_id, deadline: 1.month.from_now)
  end

  def user_vote(user)
    Vote.where(user_id: user.id, survey_id: self.id).first
  end

  def user_voted?(user)
    user_vote(user) ? true : false
  end

  def ended?
    self.deadline.past?
  end

  def vote_average
    votes = Vote.where(survey_id: self.id)
    votes.sum('takedown') / votes.count.to_f
  end

  def takedown_result
    self.vote_average >= 3 ? false : true
  end
end