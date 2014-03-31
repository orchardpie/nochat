class MessagesController < ApplicationController
  respond_to :json
  respond_to :html, only: :index

  before_filter :authenticate_user!

  def index
    respond_with()
  end

  def create
    @message = Message.create(message_params.merge(sender_id: current_user.id))
    respond_with(@message)
  end

  private

  def message_params
    params.require(:message).permit(:receiver_id, :body)
  end
end

