class DeviceRegistration
  include ActiveModel::Model

  class << self
    def create(params)
      DeviceRegistration.new(**params.symbolize_keys).tap { |dr| dr.save }
    end
  end

  validate :valid_device

  def initialize(user:, token:)
    if @device = Device.find_by(token: token)
      @device.user = user
    else
      @device = user.devices.build(token: token)
    end
  end

  def save
    @device.save
  end

  private

  def valid_device
    if !@device.valid?
      @device.errors.each do |field, message|
        errors.add(field, message)
      end
    end
  end
end

