require 'spec_helper'

describe PushNotification do
  describe "#initialize" do
    subject { -> { PushNotification.new(recipient: recipient) } }

    context "with a recipient" do
      let(:recipient) { User.new }
      it { should_not raise_error }
    end

    context "without a recipient" do
      let(:recipient) { nil }
      it { should raise_error }
    end
  end

  describe "#deliver" do
    subject { -> { push.deliver } }

    let(:push) { PushNotification.new(recipient: recipient) }
    let(:recipient) { User.new }
    let(:token) { 'comeonfhqwhgads' }

    context "when the user has a device" do
      before { recipient.devices.build(token: token) }

      it { should change(APN.notifications, :count).by(+1) }

      it "should set the message on the notification" do
        subject.call
        APN.notifications.last.message.should_not be_nil
      end

      it "should set the badge count to the number of unread messages for the recipient" do
        messages = [double(:message), double(:message)]
        allow(recipient.received_messages).to receive(:unread).and_return(messages)
        subject.call
        APN.notifications.last.badge.should == messages.count
      end

      it "should send the APN to the recipient's device" do
        subject.call
        APN.notifications.last.token.should == token
      end
    end

    context "when the user has multiple devices" do
      before do
        recipient.devices.build(token: token1)
        recipient.devices.build(token: token2)
      end

      let(:token1) { 'comeonfhqwhgads' }
      let(:token2) { 'iseeyoujockingme' }

      it { should change(APN.notifications, :count).by(+2) }

      it "should send the APN to each of the recipient's devices" do
        subject.call
        APN.notifications.map(&:token).should include(token1)
        APN.notifications.map(&:token).should include(token2)
      end
    end

    context "when the user does not have a device" do
      before { recipient.devices.should be_empty }

      it { should_not change(APN.notifications, :count) }
    end
  end
end

