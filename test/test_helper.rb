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
end
