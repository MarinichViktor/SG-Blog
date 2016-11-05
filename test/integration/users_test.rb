require "test_helper"

class UsersTest < ActionDispatch::IntegrationTest
fixtures :users

  def setup
    @post=Post.first
    @user= users(:user1)
    sign_out
  end

  def test_sign_up
    visit root_path
    click_on('Sign Up')
    page.fill_in "name", :with => "name"
    page.fill_in "email", :with => "theuser@a.net"
    page.fill_in "city", :with => "rivne ukraine"
    page.fill_in "password", :with => "password"
    page.fill_in "password_confirmation", :with => "password"
    page.find('input[id="Sign Up"]').click
    assert page.has_content?(@user.name)
    assert page.has_content? ('Welcome to SG Blog .Please confirm your email address to continue.')
  end

  def sign_out
    visit root_path
    return true if page.has_content?('Sign In')
    click_on('Sign Out')
  end

  def log_in
    visit new_session_path
    return true if page.has_content? ('You already loged in system.')
    page.fill_in "email", :with => @user.email
    page.fill_in "password", :with => "password"
    page.find('input[id="login"]').click
    assert page.has_content?(@user.name)
  end
end
