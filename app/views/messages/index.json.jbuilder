json_messages = []
@messages.each do |message|
  if message.sender_id == current_user.id
    new_message = message.as_json(only: [:id, :word_count, :time_saved]).merge(disposition: 'sent')
    json_messages << new_message
  end

  if message.receiver_id == current_user.id
    new_message = message.as_json(only: [:id, :word_count, :time_saved]).merge(disposition: 'received')
    json_messages << new_message
  end
end

json.array!(json_messages)

