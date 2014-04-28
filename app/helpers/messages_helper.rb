module MessagesHelper
  def json_for_messages(messages)
    messages.inject([]) do |jsons, message|
      if message.sent_by?(current_user)
        jsons << json_for_message(message, disposition: 'sent')
      end

      if message.received_by?(current_user)
        jsons << json_for_message(message, disposition: 'received')
      end

      jsons
    end
  end

  private

  def display_time(time_in_ms)
    time_in_seconds = [1, (time_in_ms / 1000)].max
    "#{pluralize(time_in_seconds, 'second')} saved"
  end

  def json_for_message(message, disposition:)
    message.
      as_json(only: [:id, :time_saved, :created_at]).
      merge(disposition: disposition, time_saved_description: display_time(message.time_saved))
  end
end

