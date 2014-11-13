class AdminMailer < ActionMailer::Base
  #TODO: change to an admin email address
  default from: 'peter@adjudicateonline.com'

  def invite_arbitrator(email)
    email = email

    mail(to: email, subject: "You're invited to participate in Adjudicate Online")
  end

  def dispute_submitted(dispute)
    email = 'peter@adjudicateonline.com'
    @user = dispute.user

    mail(to: email, subject: "A dispute was created")
  end

  def new_user_signup(user)
    email = 'peter@adjudicateonline.com'
    @user = user

    mail(to: email, subject: 'A new user was created')
  end
end