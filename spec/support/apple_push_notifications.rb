class << APN
  def notifications
    @notifications = [] unless @notifications
    @notifications
  end

  def reset
    @notifications = nil
  end

  def push(notification)
    notifications << notification
  end
end

