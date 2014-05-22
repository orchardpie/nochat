class PushNotification
  def initialize(recipient:)
    raise "Push notification requires a recipient" unless recipient
    @recipient = recipient
  end

  def deliver
    @recipient.devices.each do |device|
      notification = Houston::Notification.new(token: device.token)
      notification.alert = "Someone has sent you a message"
      notification.badge = @recipient.received_messages.unread.count
      APN.push(notification)
    end
  end
end

