require 'spec_helper'

describe Rsvp do
  let(:invitation) { messages(:kevin_to_new_user).invitation }

  describe "validations" do
    subject { Rsvp.new(params) }

    let(:params) {
      {
        user: user_params,
        invitation: invitation
      }
    }

    context "with a valid user" do
      let(:user_params) { { password: 'password' } }

      context "with an invitation" do
        it { should be_valid }
      end
    end

    context "with an invalid user" do
      let(:user_params) { { password: '2shrt' } }

      it { should_not be_valid }
      it { should have(1).error_on(:password) }
    end
  end

  describe "#save" do
    subject { -> { rsvp.save } }

    let(:rsvp) { Rsvp.new(params) }
    let(:params) {
      {
        user: { password: 'password' },
        invitation: invitation
      }
    }

    context "with valid params" do
      it { should change(User, :count).by(1) }
    end

    context "without valid params" do
      let(:params) { { invitation: invitation, user: { password: '2shrt' } } }

      it { should_not change(User, :count) }
    end
  end
end

