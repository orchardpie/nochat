class PushNotification
  def initialize(receiver:)
    raise "Push notification requires a receiver" unless receiver
    @receiver = receiver
  end

  def deliver
    @receiver.devices.each do |device|
      notification = Houston::Notification.new(token: device.token)
      notification.alert = "Someone has sent you a message"
      notification.badge = @receiver.received_messages.unread.count
      APN.push(notification)
    end
  end
end

