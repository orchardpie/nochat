require 'spec_helper'

describe InvitationsController do
  describe "#show" do
    subject { -> { get :show, id: invitation, format: format } }
    let(:format) { :html }

    let(:invitation) { messages(:kevin_to_new_user).invitation }

    it_should_behave_like "an action that returns", :html
    it_should_behave_like "an action that requires", :invitation

    it { should assign(:rsvp) }
  end
end

