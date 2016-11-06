require "test_helper"

class CommentsTest < ActionDispatch::IntegrationTest
  fixtures :posts, :users
  include SessionMethods

  def setup
    @user= users(:user1)
    log_out
  end

  def test_sign_in
    visit root_path
    click_on('Sign In')
    page.fill_in "email", :with => @user.email
    page.fill_in "password", :with => "password"
    page.find('input[id="login"]').click
    assert page.has_content?(@user.name)
    assert page.has_content? ('You loged in system.')
  end

  def test_sign_out
    visit root_path
    log_in(@user)
    click_on('Sign Out')
    assert page.has_content?('Sign In')
    visit edit_user_path(@user)
    assert page.has_content?('You need to login.')
  end


end
