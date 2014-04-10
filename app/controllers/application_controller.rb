class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  skip_before_action :verify_authenticity_token, if: ->{ request.format.json? }

  acts_as_token_authentication_handler_for User
end

