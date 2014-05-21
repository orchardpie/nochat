require 'spec_helper'

describe DeviceRegistration do
  let(:user) { users(:kevin) }
  let(:token) { "comeonfhqwghads" }

  describe "validations" do
    subject { DeviceRegistration.new(user: user, token: token) }

    context "with a token" do
      it { should be_valid }
    end

    context "without a token" do
      let(:token) { nil }

      it { should_not be_valid }
      it { should have(1).error_on(:token) }
    end
  end

  describe "#save" do
    subject { -> { device_registration.save } }

    let(:device_registration) { DeviceRegistration.new(user: user, token: token) }

    context "with a new device" do
      it { should change{ user.reload.devices.map(&:token) }.to([token]) }
      it { should change(Device, :count).by(1) }
    end

    context "with a device that's already registered" do
      before { randall.devices.create!(token: token) }

      let(:randall) { users(:randall) }

      it { should change{ user.devices.reload.map(&:token) }.to([token]) }
      it { should change{ randall.devices.reload.map(&:token) }.to([]) }
      it { should_not change(Device, :count).by(1) }
    end
  end
end

