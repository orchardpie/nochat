module MessagesHelper
  def display_time(time_in_ms)
    time_in_seconds = [1, (time_in_ms / 1000)].max
    "#{pluralize(time_in_seconds, 'second')} saved"
  end
end
