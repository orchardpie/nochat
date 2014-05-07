# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
require 'byebug'
require 'support/fixture_builder'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

# Checks for pending migrations before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)

module HandleExceptionsInSpecs
  def process(*)
    super
  rescue ActiveRecord::RecordNotFound
    @response.status = 404
  rescue ActionController::UnknownFormat
    @response.status = 406
  end
end

module CurrentUserInViews
  extend ActiveSupport::Concern

  included do
    alias_method_chain :setup_with_controller, :current_user
  end

  def setup_with_controller_with_current_user
    setup_with_controller_without_current_user

    view.class_eval { attr_accessor :current_user }
  end
end

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.global_fixtures = :all

  config.use_transactional_fixtures = true

  config.order = "random"

  config.include Devise::TestHelpers, type: :controller
  config.include HandleExceptionsInSpecs, type: :controller
  config.include CurrentUserInViews, type: :view

  config.before(:each) { ActionMailer::Base.deliveries.clear }
end

