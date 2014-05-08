class Rsvp
  include ActiveModel::Model

  attr_accessor :user, :invitation

  validate :valid_user

  class << self
    def create(params)
      Rsvp.new(**params.symbolize_keys).tap { |rsvp| rsvp.save }
    end
  end

  def initialize(invitation:, user:)
    @invitation = invitation
    @user = User
      .new(user.merge(email: @invitation.message.receiver_email))
    @errors = ActiveModel::Errors.new(self)
  end

  def save
    if @user.save
      Message.where(receiver_email: @user.email).each do |message|
        message.update_attributes(receiver_id: @user.id)
        message.invitation.update_attributes(responded_to: true)
      end

      true
    end
  end

  private

  def valid_user
    if !@user.valid?
      @user.errors.each do |field, message|
        errors.add(field, message)
      end
    end
  end
end

