json.user do
  json.subresources do
    json.messages messages_path
  end
end
json.partial! 'messages/messages', messages: @messages

