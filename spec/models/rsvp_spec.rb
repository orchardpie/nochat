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
    let(:params) { { user: { email: 'iliketurtles@orchardpie.com', password: 'password' } } }

    context "with valid params" do
      it { should change(User, :count).by(1) }
    end

    context "without valid params" do
      let(:params) { { } }

      it { should_not change(User, :count) }
    end

    context "with an invitation associated to the new user" do
      let!(:message) { Message.create(sender: users(:kevin), receiver_email: 'iliketurtles@orchardpie.com', body: 'I LIKE TURTLES') }
      let(:invitation) { message.invitation }

      it { should change { invitation.reload.responded_to? }.to(true) }
      it { should change { message.reload.receiver_id } }
    end

    context "with an invitation not associated to the new user" do
      let!(:message) { Message.create(sender: users(:kevin), receiver_email: 'ihateturtles@orchardpie.com', body: 'SCREW YOU, I LIKE TURTLES') }
      let(:invitation) { message.invitation }

      it { should_not change { invitation.reload.responded_to? } }
      it { should_not change { message.reload.receiver_id } }
    end
  end
end

