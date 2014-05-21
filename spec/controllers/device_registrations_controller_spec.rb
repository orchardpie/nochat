require 'spec_helper'

describe DeviceRegistrationsController do
  let(:current_user) { users(:kevin) }
  before { sign_in current_user }

  describe '#create' do
    subject { -> { post :create, device_registration: { token: token }, format: format } }

    let(:format) { :json }
    let(:token) { 'comeonfhwhgads' }

    it_should_behave_like "an action that returns", :json
    it_should_behave_like "a non-navigational action that requires a login"
  end
end

