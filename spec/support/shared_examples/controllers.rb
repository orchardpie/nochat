shared_examples_for "an action that requires a login" do
  before { sign_out :user }
  it { should respond_with_redirect_to(new_user_session_path) }
end

shared_examples_for "a non-navigational action that requires a login" do
  before { sign_out :user }
  context "without authentication" do
    it { should respond_with_status :unauthorized }
  end
end

shared_examples_for "an action that returns" do |*acceptable_formats|
  acceptable_formats.each do |acceptable_format|
    context "expecting a response in #{acceptable_format} format" do
      let(:format) { acceptable_format }
      it { should_not respond_with_status :not_acceptable }
    end
  end

  (%i(html js json xml csv) - acceptable_formats.collect(&:to_sym)).each do |unacceptable_format|
    context "expecting a response in #{unacceptable_format} format" do
      let(:format) { unacceptable_format }
      it { should respond_with_status :not_acceptable }
    end
  end
end

