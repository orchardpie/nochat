class MessagesController < ApplicationController
  respond_to :json
  respond_to :html, only: :index

  before_filter :authenticate_user!

  def index
    @messages = current_user.messages
    respond_with(@messages)
  end

  def create
    @message = current_user.sent_messages.create(message_params)
    respond_with(@message)
  end

  private

  def message_params
    params.require(:message).permit(:receiver_email, :body)
  end
end

