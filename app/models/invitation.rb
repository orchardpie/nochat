class Invitation < ActiveRecord::Base
  belongs_to :message

  before_create :generate_token
  after_commit :send_invitation_email, on: :create

  class << self
    def find_by_param(param)
      self.find_by(token: param)
    end

    def find_by_param!(param)
      self.find_by!(token: param)
    end
  end

  def to_param
    token
  end

  private

  def generate_token
    self.token = SecureRandom.uuid
  end

  def send_invitation_email
    NoChatMailer.invitation(self).deliver
  end
end

