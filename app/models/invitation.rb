class Invitation < ActiveRecord::Base
  belongs_to :message

  before_create :generate_token
  after_commit :send_invitation_email, on: :create

  private

  def generate_token
    self.token = SecureRandom.uuid
  end

  def send_invitation_email
    NoChatMailer.invitation(message).deliver
  end
end

