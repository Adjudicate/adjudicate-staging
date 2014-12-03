class AdminMailer < ActionMailer::Base
  #TODO: change to an admin email address
  default from: 'peter@adjudicateonline.com'

  def invite_arbitrator(user, dispute, temp_pw)
    email = user.email
    @dispute = dispute
    @temp_pw = temp_pw

    mail(to: email, subject: "You're invited to participate in Adjudicate Online")
  end

  def dispute_submitted(dispute)
    to_email = 'peter@adjudicateonline.com'
    @email = dispute.creator_email

    mail(to: to_email, subject: "A dispute was created")
  end

  def new_user_signup(user)
    email = 'peter@adjudicateonline.com'
    @user = user

    mail(to: email, subject: 'A new user was created')
  end

  def send_confirmation_email(dispute)
    @dispute = dispute
    
    mail(to: @dispute.creator_email, subject: "Your dispute was created")
  end
end