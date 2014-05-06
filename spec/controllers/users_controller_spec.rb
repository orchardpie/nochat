require 'spec_helper'

describe UsersController do
  let(:current_user) { users(:kevin) }
  let(:format) { :json }
  before { sign_in(:user, current_user) }

  describe '#show' do
    subject { -> { get :show, id: user, format: format } }
    let(:user) { current_user }

    it_should_behave_like "an action that returns", :json
    it_should_behave_like "a non-navigational action that requires a login"
    it_should_behave_like "an action that requires", :user

    context "when the user is the current user" do
      it { should respond_with_template(:show) }
      it { should assign(:user) }
    end

    context "when the user is not the current user" do
      let(:user) { users(:randall) }
      it { should respond_with_status(:missing) }
    end
  end
end

