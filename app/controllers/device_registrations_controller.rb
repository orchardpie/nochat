class DeviceRegistrationsController < ApplicationController
  respond_to :json

  def create
    @device_registration = DeviceRegistration.create(device_registration_params.merge(user: current_user))

    respond_with @device_registration
  end

  private

  def device_registration_params
    params.require(:device_registration).permit(:token)
  end
end

