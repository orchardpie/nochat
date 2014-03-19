class MessagesController < ApplicationController
  respond_to :html, :json

  before_filter :authenticate_user!

  def index
    respond_with()
  end
end

