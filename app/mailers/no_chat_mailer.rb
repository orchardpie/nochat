class NoChatMailer < ActionMailer::Base
  default from: "please-reply-via-nochat@nochat.me"

  def invitation(invitation)
    @invitation = invitation
    mail(to: invitation.message.receiver_email, subject: "Someone has sent you a message via NoChat")
  end
end

