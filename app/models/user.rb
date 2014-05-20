class User < ActiveRecord::Base
  acts_as_token_authenticatable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :sent_messages, class_name: "Message", foreign_key: :sender_id
  has_many :received_messages, class_name: "Message", foreign_key: :receiver_id do
    def unread
      self.where(unread: true)
    end
  end
  has_many :devices

  before_create :add_device
  after_create :accept_all_outstanding_invitations

  attr_accessor :device_token

  def messages
    Message.where("sender_id = :user OR receiver_id = :user", user: self).order(id: :desc).tap do |messages|
      messages.where(receiver_id: self).update_all(unread: false)
    end
  end

  private

  def add_device
    devices.build(token: device_token) if device_token.present?
  end

  def accept_all_outstanding_invitations
    Message.where(receiver_email: email).each do |message|
      message.update_attributes(receiver_id: id)
      message.invitation.update_attributes(responded_to: true)
    end
  end
end

