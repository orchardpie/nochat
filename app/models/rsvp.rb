class Rsvp
  include ActiveModel::Model

  attr_accessor :user

  validate :valid_user

  def initialize(params)
    self.user = User.new(params[:user])
    @errors = ActiveModel::Errors.new(self)
  end

  def save
    user.save
  end

  private

  def valid_user
    if !user.valid?
      user.errors.each do |field, message|
        errors.add(field, message)
      end
    end
  end
end

