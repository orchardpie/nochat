shared_examples_for "an action that requires a login" do
  before { sign_out :user }
  it { should respond_with_redirect_to(new_user_session_path) }
end

shared_examples_for "a non-navigational action that requires a login" do
  before { sign_out :user }
  context "without authentication" do
    it { should respond_with_status :unauthorized }
  end

  context "with a valid token" do
    before do
      request.headers["X-User-Token"] = users(:kevin).authentication_token
      request.headers["X-User-Email"] = users(:kevin).email
    end

    it { should_not respond_with_status :unauthorized }
  end

  context "with basic auth" do
    before do
      user.update_attributes(password: 'a valid password', password_confirmation: 'a valid password')
      request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(user.email, 'a valid password')
    end

    let(:user) { users(:kevin) }

    it { should_not respond_with_status :unauthorized }

    it "should return a fresh token in the header"
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

