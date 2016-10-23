ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require "capybara/rails"
require "minitest/rails/capybara"
require 'capybara/webkit'

Capybara.javascript_driver = :selenium
Capybara.default_max_wait_time = 5

class ActiveSupport::TestCase
  include Capybara::DSL
end
class   ActionDispatch::IntegrationTest < ActiveSupport::TestCase
  include Rails.application.routes.url_helpers
  def teardown
    Capybara.use_default_driver
  end
end
