ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require "capybara/rails"
require "minitest/rails/capybara"
require 'capybara/webkit'
require 'database_cleaner'

DatabaseCleaner.strategy = :truncation
Capybara.javascript_driver = :selenium

module JsWebkit
  def setup
    DatabaseCleaner.clean
    Capybara.current_driver = Capybara.javascript_driver
  end

  def teardown
    Capybara.use_default_driver
  end
end
class ActiveSupport::TestCase
  include Capybara::DSL
end

class IntegrationCase < ActiveSupport::TestCase
  include JsWebkit
end
