require 'spec_helper'

describe Invitation do
  let(:invitation) { Invitation.new(message_id: messages(:kevin_to_randall).id) }

  describe "before create" do
    subject { -> { invitation.save! } }
    before { invitation.should be_new_record }

    it { should change(invitation, :token).to be_present }
  end

  describe "after commit" do
    subject { -> { invitation.run_callbacks(:commit) } }
    before { invitation.stub(:transaction_record_state).and_return(new_record?) }

    context "on create" do
      let(:new_record?) { true }
      it { should change(ActionMailer::Base.deliveries, :count).by(+1) }
    end

    context "on update" do
      let(:new_record?) { false }
      it { should_not change(ActionMailer::Base.deliveries, :count) }
    end
  end
end

