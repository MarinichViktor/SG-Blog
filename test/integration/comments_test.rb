require "test_helper"

class SessionsTest < ActionDispatch::IntegrationTest
  fixtures :posts, :users
include Authorization
  def setup
    super
    @user=users(:user1)
    Capybara.current_driver = Capybara.javascript_driver
    log_in(@user)
  end

  def teardown
    super
  end

  def test_add_comment_with_invalid_values
    visit root_path
    first('.btn').click
    ['https://google.com','x','First post!'].each do |t|
      page.fill_in "comment_body", :with => t
      click_on("comment_submit")
      assert page.has_no_content?(t)
      assert page.has_content?("Your comment is invalid. Please, change it.")
    end
  end

end
