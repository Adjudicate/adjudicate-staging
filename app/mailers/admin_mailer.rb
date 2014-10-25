class AdminMailer < ActionMailer::Base
  #TODO: change to an admin email address
  default from: 'peter@adjudicateonline.com'

  def invite_arbitrator(params)
    email = params[:email]

    mail(to: email, subject: "You're invited to participate in Adjudicate Online")
  end
end