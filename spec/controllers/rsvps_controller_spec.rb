require 'spec_helper'

describe RsvpsController do
  describe '#create' do
    subject { -> { post :create, invitation_id: invitation, rsvp: params, format: format } }

    let(:invitation) { messages(:kevin_to_new_user).invitation }
    let(:format) { :html }
    let(:params) { { user: { password: 'iliketurtles' } } }

    it_should_behave_like "an action that returns", :html
    it_should_behave_like "an action that requires", :invitation

    context "with a valid RSVP" do
      it { should respond_with_redirect_to(new_user_session_path) }
    end

    context "with an invalid RSVP" do
      let(:params) { { user: { password: '2shrt' } } }

      it { should respond_with_template('invitations/show') }
    end
  end
end

