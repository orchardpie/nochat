require 'spec_helper'

describe Rsvp do
  let(:invitation) { messages(:kevin_to_new_user).invitation }

  describe "validations" do
    subject { Rsvp.new(params) }

    let(:params) {
      {
        user: user_params,
        invitation: invitation
      }
    }

    context "with a valid user" do
      let(:user_params) { { password: 'password' } }

      context "with an invitation" do
        it { should be_valid }
      end
    end

    context "with an invalid user" do
      let(:user_params) { { password: '2shrt' } }

      it { should_not be_valid }
      it { should have(1).error_on(:password) }
    end
  end

  describe "#save" do
    subject { -> { rsvp.save } }

    let(:rsvp) { Rsvp.new(params) }
    let(:params) {
      {
        user: { password: 'password' },
        invitation: invitation
      }
    }

    context "with valid params" do
      it { should change(User, :count).by(1) }

      it { should change { invitation.reload.responded_to? }.to(true) }
      it { should change { invitation.message.reload.receiver_id } }

      context "with other invitations associated to the user's e-mail" do
        let!(:other_message) { Message.create(sender: users(:kevin), receiver_email: invitation.message.receiver_email, body: 'I LIKE TURTLES') }
        let(:other_invitation) { other_message.invitation }

        it { should change { other_invitation.reload.responded_to? } }
        it { should change { other_message.reload.receiver_id } }
      end

      context "with other invitations not associated the user's e-mail" do
        let!(:other_message) { Message.create(sender: users(:kevin), receiver_email: 'ihateturtles@orchardpie.com', body: 'SCREW YOU, I LIKE TURTLES') }
        let(:other_invitation) { other_message.invitation }

        it { should_not change { other_invitation.reload.responded_to? } }
        it { should_not change { other_message.reload.receiver_id } }
      end
    end

    context "without valid params" do
      let(:params) { { invitation: invitation, user: { password: '2shrt' } } }

      it { should_not change(User, :count) }

      it { should_not change { invitation.reload.responded_to? }.to(true) }
      it { should_not change { invitation.message.reload.receiver_id } }
    end
  end
end

