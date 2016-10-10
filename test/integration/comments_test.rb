require "test_helper"

class CommentsTest < ActiveSupport::TestCase
  def setup
    @post=Post.create(title: 'AnarchyInUk', body: 'Anarchy'*30)
    visit "/posts/#{@post.id}"
  end

  def test_add_comment_to_current_post_and_see_comment_at_current_post_page
     assert_difference  "Post.find(@post.id).comments.count", 1 do
     page.fill_in "comment_body", :with => 'Anarchy'
     click_on("comment_submit")
   end
  end

  def test_try_to_add_comment_with_less_that_5_characters_and_see_no_changes
    assert_difference  "Post.find(@post.id).comments.count", 0 do
    page.fill_in "comment_body", :with => 'Ana'
    click_on("comment_submit")
  end
  end

  def test_add_comment_and_see_this_comment_on_post_page
     page.fill_in "comment_body", :with => "Hello , this is new comment to yours post"
     click_on("comment_submit")
     page.has_content? ("Hello , this is new comment to yours post")
   end

end
