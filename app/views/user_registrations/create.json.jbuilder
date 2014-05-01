json.location user_path(@user)
json.data do
  json.messages do
    json.partial! 'messages/index', user: @user, messages: @user.messages
  end
end

