require 'spec_helper'

describe User do
  describe "#messages" do
    subject { user.messages }

    let(:user) { users(:kevin) }
    let(:randall) { users(:randall) }

    context "with a message sent by the user" do
      let!(:message) { Message.create!(sender: user, receiver: randall, body: "updog") }

      it { should include(message) }
    end

    context "with a message received by the user" do
      let!(:message) { Message.create!(sender: randall, receiver: user, body: "what is updog") }

      it { should include(message) }
    end
  end
end

