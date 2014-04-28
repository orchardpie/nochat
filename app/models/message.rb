class Message < ActiveRecord::Base
  AVERAGE_MS_PER_WORD = 240

  belongs_to :sender, class_name: "User"
  belongs_to :receiver, class_name: "User"

  attr_accessor :message, :receiver_email

  validates :sender_id, :receiver_id, :body, presence: true

  before_save :generate_word_count, :generate_time_saved
  before_validation :fetch_receiver_by_email, if: ->(record){ record.receiver_email.present? }

  def sent_by?(user)
    sender_id == user.id
  end

  def received_by?(user)
    receiver_id == user.id
  end

  private

  def generate_word_count
    self.word_count = body.scan(/\w+/).size
  end

  def generate_time_saved
    self.time_saved = word_count * AVERAGE_MS_PER_WORD
  end

  def fetch_receiver_by_email
    self.receiver_id = User.find_by_email(receiver_email).try(:id)
  end
end

