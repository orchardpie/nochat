require 'spec_helper'

describe Invitation do
  let(:invitation) { Invitation.new(message_id: messages(:kevin_to_randall).id) }

  describe "before_create" do
    subject { -> { invitation.save! } }
    before { invitation.should be_new_record }

    it { should change(invitation, :token).to be_present }
  end
end

