require 'spec_helper'

describe UserRegistrationsController do
  before { @request.env["devise.mapping"] = Devise.mappings[:user] }

  describe "#create" do
    subject { -> { post :create, user: params, format: format } }
    let(:params) { { email: 'anyemail@example.com', password: 'password', password_confirmation: 'password' } }

    it_should_behave_like "an action that returns", :json, :html
  end
end

