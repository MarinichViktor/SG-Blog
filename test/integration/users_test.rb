require "test_helper"

class UsersTest < ActionDispatch::IntegrationTest
fixtures :users
  include Authorization

  def setup
    @user= users(:user1)
    log_out
  end

  def test_create_new_user_and_sing_up
     visit root_path
     assert_difference 'User.count', 1 do
      click_on('Sign Up')
      page.fill_in "name", :with => "name_uniq"
      page.fill_in "email", :with => "theuser@a.net"
      page.fill_in "city", :with => "rivne ukraine"
      page.fill_in "password", :with => "password"
      page.fill_in "password_confirmation", :with => "password"
      page.find('input[id="Sign Up"]').click
    end
    assert page.has_content?("name_uniq")
    assert page.has_content? ('Welcome to SG Blog .Please confirm your email address to continue.')
  end

  def test_edit_user
    log_in(@user)
    assert page.has_content?(@user.name)
    click_on ('Settings')
    page.fill_in "name", :with => "My new name"
    page.fill_in "password", :with => "password"
    page.fill_in "password_confirmation", :with => "password"
    page.find('input[id="Edit"]').click
    assert page.has_content?("Updated succefully")
  end

  def test_fail_edit_without_user_password
    log_in(@user)
    visit edit_user_path(@user)
    page.fill_in "name", :with => "My new name"
    page.find('input[id="Edit"]').click
    assert page.has_content?("Invalid password")
  end

end
