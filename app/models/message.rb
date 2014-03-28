class Message < ActiveRecord::Base
  AVERAGE_MS_PER_WORD = 240

  belongs_to :sender, class_name: "User"
  belongs_to :receiver, class_name: "User"

  attr_accessor :message

  validates :sender_id, :receiver_id, :body, presence: true

  before_save :generate_word_count, :generate_time_saved

  private

  def generate_word_count
    self.word_count = body.scan(/\w+/).size
  end

  def generate_time_saved
    self.time_saved = word_count * AVERAGE_MS_PER_WORD
  end
end

