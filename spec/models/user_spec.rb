require 'spec_helper'

describe User do
  let(:user) { users(:kevin) }

  describe "#received_messages.unread" do
    subject { user.received_messages.unread }
    let(:other_user) { users(:randall) }

    context "with a message with the user as the recipient" do
      let(:message) { Message.create(sender: other_user, receiver_email: user.email, body: 'I LIKE TURTLES') }

      context "which has not been read" do
        before { message.should be_unread }
        it { should include(message) }
      end

      context "which has been read" do
        before { message.update_column(:unread, false) }
        it { should_not include(message) }
      end
    end

    context "with a message with the user as the sender" do
      let!(:message) { Message.create(sender: user, receiver_email: other_user.email, body: 'I HATE TURTLES') }
      it { should_not include(message) }
    end
  end

  describe "before create" do
    subject { -> { user.save! } }

    let(:user) { User.new(email: 'totesmcgoats@orchardpie.com', password: 'password', device_token: device_token) }

    context "with a device token" do
      let(:device_token) { "nicedevicetoken" }

      it { should change(user.devices, :count).by(+1) }
      it { should change { user.devices.last.try(:token) }.to(device_token) }
    end

    context "without a device token" do
      let(:device_token) { nil }

      it { should_not change(user.devices, :count) }
    end

    context "with a blank device token" do
      let(:device_token) { "" }

      it { should_not change(user.devices, :count) }
    end
  end

  describe "after create" do
    subject { -> { user.save! } }

    let(:user) { User.new(email: 'totesmcgoats@orchardpie.com', password: 'password') }

    context "with outstanding invitations for the new user" do
      let!(:message) { Message.create(sender: users(:kevin), receiver_email: user.email, body: 'I LIKE TURTLES') }
      let(:invitation) { message.invitation }

      it { should change { invitation.reload.responded_to? } }
      it { should change { message.reload.receiver_id } }
    end

    context "with outstanding invitations for a different user" do
      let!(:message) { Message.create(sender: users(:kevin), receiver_email: 'ihateturtles@orchardpie.com', body: 'SCREW YOU, I LIKE TURTLES') }
      let(:invitation) { message.invitation }

      it { should_not change { invitation.reload.responded_to? } }
      it { should_not change { message.reload.receiver_id } }
    end
  end

  describe "#messages" do
    subject { user.messages }

    let(:user) { users(:kevin) }
    let(:randall) { users(:randall) }

    context "with a message sent by the user" do
      let!(:message) { user.sent_messages.create!(receiver_email: randall.email, body: "updog") }

      it { should include(message) }
      it "should leave the message as unread" do
        subject
        message.reload.should be_unread
      end
    end

    context "with a message received by the user" do
      let!(:message) { randall.sent_messages.create!(receiver_email: user.email, body: "what is updog") }

      it { should include(message) }
      it "should mark the message as read" do
        subject
        message.reload.should_not be_unread
      end
    end
  end
end

