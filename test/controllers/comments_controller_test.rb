require "test_helper"

class CommentsControllerTest < ActionController::TestCase
fixtures :users,:posts

  def setup
    @user=users(:user1)
    @post=posts(:one)
  end

  def test_create_comment_with_AJAX
    login(@user)
    assert_difference('Comment.count',1) do
      xhr :post, :create, format: :js, post_id: @post.id,  comment: { text: "new comment"}
      assert_response :success
   end
  end

  def test_create_comment_with_invalid_values
    login(@user)
    ['https://google.com','x','First post!'].each do |v|
      assert_difference('Comment.count',0) do
        xhr :post, :create, format: :js, post_id: @post.id,  comment: { text: v}
        assert_response :success
      end
   end
  end
end
