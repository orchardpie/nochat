require 'spec_helper'

describe Device do
  describe "validations" do
    subject { Device.new(user: user, token: token) }

    let(:user) { users(:kevin) }
    let(:token) { "comeonfhqwghads" }

    context "with a user" do
      context "with a token" do
        it { should be_valid }
      end

      context "without a token" do
        let(:token) { nil }

        it { should_not be_valid }
        it { should have(1).error_on(:token) }
      end
    end

    context "without a user" do
      let(:user) { nil }

      it { should_not be_valid }
      it { should have(1).error_on(:user) }
    end
  end
end

