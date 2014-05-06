require 'spec_helper'

describe Message do
  let(:message) { Message.new }

  describe "validations" do
    subject { Message.new(params) }

    let(:params) do
      {
        sender_id: sender_id,
        receiver_id: receiver_id,
        receiver_email: receiver_email,
        body: body
      }
    end
    let(:sender_id) { 17 }
    let(:receiver_id) { 666 }
    let(:receiver_email) { users(:kevin).email }
    let(:body) { "Hello." }

    context "with a sender, a receiver, & a message" do
      it { should be_valid }
    end

    context "without a sender" do
      let(:sender_id) { "" }
      it { should have(1).error_on(:sender_id) }
    end

    context "without a receiver email" do
      let(:receiver_id) { "" }
      let(:receiver_email) { "" }
      it { should have(1).error_on(:receiver_email) }
    end

    context "without a message" do
      let(:body) { "" }
      it { should have(1).error_on(:body) }
    end
  end

  describe "before_create" do
    subject { -> { message.save! } }

    let(:message) { Message.new(sender: users(:randall), receiver_email: "a@example.com", body: "Come on fhqwgads") }

    it { should change(message, :word_count).from(nil).to(3) }
    it { should change(message, :time_saved).from(nil).to(720) } # 240ms per word

    context "with a known receiver" do
      before { message.receiver = users(:kevin) }
      it { should_not change(message, :invitation).from(nil) }
    end

    context "without a known receiver" do
      before { message.receiver.should be_nil }
      it { should change(message, :invitation).from(nil) }
    end
  end

  context "before_validation" do
    subject { -> { message.run_callbacks(:validation) } }
    let(:receiver) { users(:randall) }

    context "when the receiver is set directly" do
      before { message.receiver = receiver }
      it { should_not change(message, :receiver_id) }
    end

    context "when the receiver is set by e-mail" do
      before { message.receiver_email = receiver.email }
      it { should change(message, :receiver_id).from(nil).to(receiver.id) }
    end

    context "when the receiver's e-mail is specified with silly casing" do
      before { message.receiver_email = receiver.email.upcase }
      it { should change(message, :receiver_id).from(nil).to(receiver.id) }
    end
  end

  describe "#sent_by?" do
    subject { message.sent_by?(user) }
    let(:message) { Message.new(sender: sender) }
    let(:user) { User.new(id: 7) }

    context "when the user's ID matches the message's sender ID" do
      let(:sender) { user }
      it { should be_true }
    end

    context "when the user's ID does not match the message's sender ID" do
      let(:sender) { User.new(id: 8) }
      it { should_not be_true }
    end
  end

  describe "#received_by?" do
    subject { message.received_by?(user) }
    let(:message) { Message.new(receiver: receiver) }
    let(:user) { User.new(id: 7) }

    context "when the user's ID matches the message's receiver ID" do
      let(:receiver) { user }
      it { should be_true }
    end

    context "when the user's ID does not match the message's receiver ID" do
      let(:receiver) { User.new(id: 8) }
      it { should_not be_true }
    end
  end
end

