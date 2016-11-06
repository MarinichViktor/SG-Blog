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
include Rails.application.routes.url_helpers

class ActiveSupport::TestCase
  include Capybara::DSL

  def login(user)
      old_controller = @controller
      @controller = SessionsController.new
      post :create, session: { email:  user.email, password: 'password' }
      @controller = old_controller
  end
end

class   ActionDispatch::IntegrationTest < ActiveSupport::TestCase
  def setup
    #DatabaseCleaner.start
  end
  def teardown
    Capybara.use_default_driver
  #  DatabaseCleaner.clean
  end

end

  module  Authorization
    def log_out
      visit root_path
      return true if page.has_content?('Sign In')
      click_on('Sign Out')
    end

    def log_in (user)
      visit (session/new)
      return true if page.has_content? ('You already loged in system.')
      page.fill_in "email", :with => user.email
      page.fill_in "password", :with => "password"
      page.find('input[id="login"]').click
    end
  end
