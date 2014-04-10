class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  skip_before_action :verify_authenticity_token, if: ->{ request.format.json? }
  before_action :include_user_authentication_token, if: ->{ request.format.json? && user_signed_in? }

  acts_as_token_authentication_handler_for User

  private

  def include_user_authentication_token
    response.headers["X-User-Token"] = current_user.authentication_token
  end
end

