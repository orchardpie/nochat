class Device < ActiveRecord::Base
  belongs_to :user

  validates :user, :token, presence: true
end

