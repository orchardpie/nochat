require 'spec_helper'

describe MessagesController do
  let(:current_user) { users(:kevin) }
  before { sign_in current_user }

  describe '#index' do
    subject { -> { get :index, format: format } }
    let(:format) { :html }

    it_should_behave_like "an action that requires a login"
    it_should_behave_like "an action that returns", :html, :json
  end

  describe '#create' do
    subject { -> { put :create, message: params, format: format } }
    let(:format) { :json }
    let(:params) { { receiver_id: 1, body: 'What up Kevino!' } }

    it_should_behave_like "a non-navigational action that requires a login"
    it_should_behave_like "an action that returns", :json

    context "with valid params" do
      it { should change(Message, :count).by(+1) }

      it { should assign(:message) }

      it "should assign the sender" do
        subject.call
        assigns(:message).sender_id.should == current_user.id
      end

      it { should respond_with_template(:create) }
    end

    context "without valid params" do
      let(:params) { { body: 'What up Kevino!' } }

      it "should not create a message" do
        expect(subject).not_to change(Message, :count)
      end
    end
  end
end

