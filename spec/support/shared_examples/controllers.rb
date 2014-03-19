shared_examples_for "an action that requires a login" do
  before { sign_out :user }
  it { should respond_with_redirect_to(new_user_session_path) }
end

