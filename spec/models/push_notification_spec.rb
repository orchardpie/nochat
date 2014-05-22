require 'spec_helper'

describe PushNotification do
  describe "#initialize" do
    subject { -> { PushNotification.new(receiver: receiver) } }

    context "with a receiver" do
      let(:receiver) { User.new }
      it { should_not raise_error }
    end

    context "without a receiver" do
      let(:receiver) { nil }
      it { should raise_error }
    end
  end

  describe "#deliver" do
    subject { -> { push.deliver } }

    let(:push) { PushNotification.new(receiver: receiver) }
    let(:receiver) { User.new }
    let(:token) { 'comeonfhqwhgads' }

    context "when the user has a device" do
      before { receiver.devices.build(token: token) }

      it { should change(APN.notifications, :count).by(+1) }

      it "should set the message on the notification" do
        subject.call
        APN.notifications.last.message.should_not be_nil
      end

      it "should set the badge count to the number of unread messages for the receiver" do
        messages = [double(:message), double(:message)]
        allow(receiver.received_messages).to receive(:unread).and_return(messages)
        subject.call
        APN.notifications.last.badge.should == messages.count
      end

      it "should send the APN to the receiver's device" do
        subject.call
        APN.notifications.last.token.should == token
      end
    end

    context "when the user has multiple devices" do
      before do
        receiver.devices.build(token: token1)
        receiver.devices.build(token: token2)
      end

      let(:token1) { 'comeonfhqwhgads' }
      let(:token2) { 'iseeyoujockingme' }

      it { should change(APN.notifications, :count).by(+2) }

      it "should send the APN to each of the receiver's devices" do
        subject.call
        APN.notifications.map(&:token).should include(token1)
        APN.notifications.map(&:token).should include(token2)
      end
    end

    context "when the user does not have a device" do
      before { receiver.devices.should be_empty }

      it { should_not change(APN.notifications, :count) }
    end
  end
end

