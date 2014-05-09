require 'spec_helper'

describe "invitations/show.html.slim" do
  subject { render }
  let(:invitation) { messages(:kevin_to_new_user).invitation }
  before do
    assign(:invitation, invitation)
    assign(:rsvp, Rsvp.new(invitation: invitation, user: {}))
  end

  context "with an invitation that is awaiting a response" do
    before { invitation.responded_to?.should be_false }

    context "with no current user" do
      before { view.current_user.should be_nil }

      it "should have user info fields" do
        subject.should match(/password/)
      end
    end

    context "with a current user" do
      before { view.current_user = users(:randall) }

      it "should not have user info fields" do
        subject.should_not match(/password/)
      end
    end
  end

  context "with an invitation that has already been responded to" do
    before { invitation.responded_to = true }

    it "should not have user info fields" do
      subject.should_not match(/password/)
    end
  end
end

