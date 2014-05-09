require 'spec_helper'

describe User do
  describe "after create" do
    subject { -> { user.save } }

    let(:user) { User.new(email: 'totesmcgoats@orchardpie.com', password: 'password') }

    before { user.stub(:transaction_record_state).and_return(true) }

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
    end

    context "with a message received by the user" do
      let!(:message) { randall.sent_messages.create!(receiver_email: user.email, body: "what is updog") }

      it { should include(message) }
    end
  end
end

