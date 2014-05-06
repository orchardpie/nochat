class Message < ActiveRecord::Base
  AVERAGE_MS_PER_WORD = 240

  has_one :invitation
  belongs_to :sender, class_name: "User"
  belongs_to :receiver, class_name: "User"

  attr_accessor :message

  validates :sender_id, :receiver_email, :body, presence: true

  before_create :build_invitation, unless: :receiver_id
  before_create :generate_word_count, :generate_time_saved
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
    if user = User.find_by('lower(email) = lower(:email)', email: receiver_email)
      self.receiver_id = user.id
    end
  end
end

