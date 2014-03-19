require 'spec_helper'

describe MessagesController do
  before { sign_in users(:kevin) }

  describe '#index' do
    subject { -> { get :index, format: format } }
    let(:format) { :html }

    it_should_behave_like "an action that requires a login"
    it_should_behave_like "an action that returns", :html, :json
  end
end

