require 'spec_helper'

describe "messages/index.json.jbuilder" do
  subject { render; JSON.parse(rendered).with_indifferent_access }
  let(:current_user) { users(:kevin) }
  let(:randall) { users(:randall) }

  before do
    view.current_user = current_user
    assign(:messages, current_user.messages)
  end

  its([:location]) { should be_present }

  context "with a message sent by the current user" do
    let!(:sent_message) { Message.create(sender: current_user, receiver: randall, body: "does it smell like updog in here?") }

    it "should include the message" do
      subject["data"].detect { |message| message['id'] == sent_message.id }.should_not be_empty
    end

    it "should set the message's disposition to 'sent'" do
      subject["data"].detect { |message| message['id'] == sent_message.id }['disposition'].should == 'sent'
    end

    it "should set the time saved description" do
      subject["data"].detect { |message| message['id'] == sent_message.id }['time_saved_description'].should == '1 second saved'
    end
  end

  context "with a message received by the current user" do
    let!(:sent_message) { Message.create(sender: randall, receiver: current_user, body: "what is updog?") }

    it "should include the message" do
      subject["data"].detect { |message| message['id'] == sent_message.id }.should_not be_empty
    end

    it "should set the message's disposition to 'received'" do
      subject["data"].detect { |message| message['id'] == sent_message.id }['disposition'].should == 'received'
    end

    it "should set the time saved description" do
      subject["data"].detect { |message| message['id'] == sent_message.id }['time_saved_description'].should == '1 second saved'
    end
  end

  context "with a message sent and received by the current user" do
    let!(:sent_message) { Message.create(sender: current_user, receiver: current_user, body: "not much what's up with you dog?") }

    it "should include the message as both sent and received messages" do
      subject["data"].detect { |message| message['id'] == sent_message.id && message['disposition'] == 'sent' }.should_not be_nil
      subject["data"].detect { |message| message['id'] == sent_message.id && message['disposition'] == 'received' }.should_not be_nil
    end
  end
end

