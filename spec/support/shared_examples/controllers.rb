shared_examples_for "an action that requires a login" do
  before { sign_out :user }
  it { should respond_with_redirect_to(new_user_session_path) }
end

shared_examples_for "an action that returns" do |*acceptable_formats|
  acceptable_formats.each do |acceptable_format|
    context "expecting a response in #{acceptable_format} format" do
      let(:format) { acceptable_format }
      it "does not respond with 406 (Unacceptable)" do
        subject.call.should_not == 406
      end
    end
  end

  (%i(html js json xml csv) - acceptable_formats.collect(&:to_sym)).each do |unacceptable_format|
    context "expecting a response in #{unacceptable_format} format" do
      let(:format) { unacceptable_format }
      it "responds with 406 (Unacceptable)" do
        subject.call.should == 406
      end
    end
  end
end

