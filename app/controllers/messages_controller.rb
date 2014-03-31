class MessagesController < ApplicationController
  respond_to :json
  respond_to :html, only: :index

  before_filter :authenticate_user!

  def index
    respond_with()
  end

  def create
    @message = current_user.sent_messages.create(message_params)
    respond_with(@message)
  end

  private

  def message_params
    params.require(:message).permit(:receiver_id, :body)
  end
end

