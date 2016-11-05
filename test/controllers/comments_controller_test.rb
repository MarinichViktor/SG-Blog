require "test_helper"

class CommentsControllerTest < ActionController::TestCase
fixtures :users,:posts

  def setup
    @user=users(:user1)
    @post=posts(:one)
  end

  def test_create_session
    login(@user)
    #assert_difference('Comment.count',1) do
    #  xhr :get, :product_update, format: :js, product_id: '77'
    #  xhr :post, :create, format: :js,id: @post.id, params: { user_id: @user, post_id: @post.id, text: "new comment"}
  #    post :create , params: { post_id: @post.id, text: "new comment"}
  #  end
  end

end
