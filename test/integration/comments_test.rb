require "test_helper"

class CommentsTest < IntegrationCase
  def setup
    super
    Post.create(title: "a1"*5, body: "U1"*100)
    visit ("/")
    first('.post-link').click
  end

  def teardown
    super
  end

  def test_add_comment_to_current_post_and_see_comment_at_current_post_page
    page.fill_in "comment_body", :with => "Hello , this is new comment to yours post"
    click_on("comment_submit")
    assert page.has_content? ("Hello , this is new comment to yours post")
    assert page.has_content?("You have add new  comment.")

  end

  def test_try_to_add_comment_with_url_see_no_changes
    ['https://google.com','x','First post!'].each do |t|
      page.fill_in "comment_body", :with => t
      click_on("comment_submit")
      assert page.has_no_content?(t)
      assert page.has_content?("Your comment is invalid. Please, change it.")

    end
  end

  def test_add_comment_and_see_this_comment_on_post_page
     page.fill_in "comment_body", :with => "Hello , this is new comment to yours post"
     click_on("comment_submit")
     page.has_content? ("Hello , this is new comment to yours post")
   end

end
