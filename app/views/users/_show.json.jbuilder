json.location user_path(user)
json.data do
  json.messages do
    json.partial! 'messages/index', user: user, messages: user.messages
  end
  json.device_registrations do
    json.location device_registrations_path
  end
end

# {
  # "location": "/users/1",
  # "data": {
    # "messages": {
      # "location": "/messages",
      # "data": [{
        # "id": 1,
        # "word_count": 5,
        # "created_at": "2014-04-25T21:39:00.199Z",
        # "time_saved": 1200,
        # "time_saved_description": "1 second saved",
        # "disposition": "received"
      # },{
        # "id": 2,
        # "word_count": 15,
        # "created_at": "2014-04-25T21:39:00.199Z",
        # "time_saved": 2400,
        # "time_saved_description": "About 2 seconds saved",
        # "disposition": "received"
      # }]
    # }
  # }
# }

