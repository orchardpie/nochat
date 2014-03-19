shared_examples_for "an action that requires a login" do
  before { sign_out :user }
  it "should redirect to the sign in page" do
    subject.call
    response.should redirect_to(new_user_session_path)
  end
end

