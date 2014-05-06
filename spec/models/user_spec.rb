require 'spec_helper'

describe User do
  describe "#messages" do
    subject { user.messages }

    let(:user) { users(:kevin) }
    let(:randall) { users(:randall) }

    context "with a message sent by the user" do
      let!(:message) { user.sent_messages.create!(receiver_email: randall.email, body: "updog") }

      it { should include(message) }
    end

    context "with a message received by the user" do
      let!(:message) { randall.sent_messages.create!(receiver_email: user.email, body: "what is updog") }

      it { should include(message) }
    end
  end
end

