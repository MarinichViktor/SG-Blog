ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require "capybara/rails"
require "minitest/rails/capybara"
require 'capybara/webkit'
require 'minitest/autorun'
require 'thread'
require 'database_cleaner'

DatabaseCleaner.strategy = :transaction
DatabaseCleaner.clean_with(:truncation)
Capybara.javascript_driver = :webkit
Capybara.default_max_wait_time = 5

class ActiveSupport::TestCase
  include Capybara::DSL
end
class   ActionDispatch::IntegrationTest < ActiveSupport::TestCase
  include Rails.application.routes.url_helpers
  def setup
    DatabaseCleaner.start
  end
  def teardown
    Capybara.use_default_driver
    DatabaseCleaner.clean
  end
end
