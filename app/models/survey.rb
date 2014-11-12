class Survey < ActiveRecord::Base
  belongs_to :dispute
  has_many :votes

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

  def yes_votes
    Vote.where(survey_id: self.id, takedown: true)
  end

  def no_votes
    Vote.where(survey_id: self.id, takedown: false)
  end

  def yes_vote_count
    yes_votes.count
  end

  def no_vote_count
    no_votes.count
  end
end