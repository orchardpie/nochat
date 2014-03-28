require 'spec_helper'

describe Message do
  describe "validations" do
    subject { Message.new(params) }
    let(:params) do
      {
        sender_id: sender_id,
        receiver_id: receiver_id,
        body: body
      }
    end
    let(:sender_id) { 17 }
    let(:receiver_id) { 666 }
    let(:body) { "Hello." }

    context "with a sender, a receiver, & a message" do
      it { should be_valid }
    end

    context "without a sender" do
      let(:sender_id) { nil }
      it { should have(1).error_on(:sender_id) }
    end

    context "without a receiver" do
      let(:receiver_id) { nil }
      it { should have(1).error_on(:receiver_id) }
    end

    context "without a message" do
      let(:body) { nil }
      it { should have(1).error_on(:body) }
    end
  end
end
