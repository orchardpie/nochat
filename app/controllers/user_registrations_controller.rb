class UserRegistrationsController < Devise::RegistrationsController
  respond_to :json, only: :create
  respond_to :html
end

