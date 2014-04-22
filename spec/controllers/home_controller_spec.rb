require 'spec_helper'

describe HomeController do
  let(:current_user) { users(:kevin) }
  before { sign_in current_user }

  describe '#index' do
    subject { -> { get :index, format: format } }

    it_should_behave_like "an action that returns", :html, :json

    context "with HTML" do
      let(:format) { :html }

      it { should respond_with_redirect_to(messages_path) }
    end

    context "with JSON" do
      let(:format) { :json }

      it { should respond_with_template(:index) }
      it { should assign(:messages) }

      it_should_behave_like "a non-navigational action that requires a login"
    end
  end
end

