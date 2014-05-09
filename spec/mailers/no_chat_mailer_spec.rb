require "spec_helper"

describe NoChatMailer do
  describe ".invitation" do
    subject { described_class.invitation(invitation) }
    let(:message) { messages(:kevin_to_new_user) }
    let(:invitation) { message.invitation }

    its(:to) { should include(message.receiver_email) }
    its(:subject) { should == "Someone has sent you a message via NoChat" }
  end
end

