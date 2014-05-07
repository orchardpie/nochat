require 'spec_helper'

describe Rsvp do
  describe "validations" do
    subject { Rsvp.new(params) }

    let(:params) { { user: user_params } }

    context "with a valid user" do
      let(:user_params) { { email: 'valid@example.com', password: 'password', password_confirmation: 'password' } }

      it { should be_valid }
    end

    context "with an invalid user" do
      let(:user_params) { { email: '', password: 'password', password_confirmation: 'password' } }

      it { should_not be_valid }
    end

    context "with no user" do
      let(:user_params) { nil }

      it { should_not be_valid }
    end
  end

  describe "#save" do
    subject { -> { rsvp.save } }

    let(:rsvp) { Rsvp.new(params) }

    context "with valid params" do
      let(:params) { { user: { email: 'iliketurtles@orchardpie.com', password: 'password' } } }

      it { should change(User, :count).by(1) }
    end

    context "without valid params" do
      let(:params) { { } }

      it { should_not change(User, :count) }
    end
  end
end

