require 'spec_helper'

describe MessagesController do
  describe '#index' do
    subject { -> { get :index } }

    it_should_behave_like "an action that requires a login"
  end
end

