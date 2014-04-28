json.location messages_path
json.data do
  json.array!(json_for_messages(messages))
end

