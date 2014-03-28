class Message < ActiveRecord::Base
  belongs_to :sender, class_name: "User"
  belongs_to :receiver, class_name: "User"

  attr_accessor :message

  validates :sender_id, :receiver_id, :body, presence: true

end

