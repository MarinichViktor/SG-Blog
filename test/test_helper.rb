ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require "capybara/rails"
require "minitest/rails/capybara"
require 'capybara/webkit'

Capybara.javascript_driver = :webkit


class ActiveSupport::TestCase
  include Capybara::DSL
  def teardown
    Capybara.use_default_driver
  end
end
