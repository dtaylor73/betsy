require "simplecov"
SimpleCov.start "rails" do
  add_filter "/lib/"
  add_filter "/vendor/"
  add_filter "/app/channels"
  add_filter "/app/jobs"
  add_filter "/app/mailers"
  add_filter "/app/controllers/application_controller.rb"
end

ENV["RAILS_ENV"] ||= "test"
require File.expand_path("../../config/environment", __FILE__)
require "rails/test_help"
require "minitest/rails"
require "minitest/reporters"

Minitest::Reporters.use!(
  Minitest::Reporters::SpecReporter.new,
  ENV,
  Minitest.backtrace_filter
)

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  def mock_auth_hash(merchant)
    return {
      provider: merchant.provider,
      uid: merchant.UID,
      info: {
        email: merchant.email,
        username: merchant.username
      }
    }
  end

  def perform_login(merchant = nil)
    merchant ||= Merchant.first

    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new(mock_auth_hash(merchant))
    get auth_callback_path(:github)
  
    return merchant
  end

  def Setup
    OmniAuth.config.test_mode = true
  end
end