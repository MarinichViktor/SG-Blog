require "test_helper"

class SessionsTest < ActionDispatch::IntegrationTest
  fixtures :posts, :users
include Authorization
  def setup
    super
    @user=users(:user1)
    Capybara.current_driver = Capybara.javascript_driver
    log_in(@user)
    visit root_path
    first('.btn').click
  end

  def teardown
    super
  end


  def test_add_comment_to_current_post_and_see_comment_at_current_post_page
    page.fill_in "comment_body", with: "Hello , this is new comment to yours post"
    click_on("comment_submit")
    assert page.has_content?("Hello , this is new comment to yours post")
    assert page.has_content?("You have add new  comment.")
  end

end
