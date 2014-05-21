require 'spec_helper'

describe "home/show.json.jbuilder" do
  subject { render; JSON.parse(rendered).with_indifferent_access }

  before { view.current_user = users(:kevin) }

  its([:location]) { should be_present }
  its([:data]) { should be_present }
  its([:data]) { should include(:messages) }
  its([:data]) { should include(:device_registrations) }
end

