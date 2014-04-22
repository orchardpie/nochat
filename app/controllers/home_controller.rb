class HomeController < ApplicationController
  respond_to :json, :html

  before_filter :authenticate_user!

  def index
    respond_to do |format|
      format.json { respond_with(@messages = current_user.messages) }
      format.html { redirect_to(messages_path) }
    end
  end
end

