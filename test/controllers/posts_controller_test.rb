require "test_helper"

class PostsControllerTest < ActionController::TestCase
fixtures :users,:posts
include Authorization
  def  setup
    @user=users(:user1)
    @post=posts(:one)
  end

  def test_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:posts)
  end

  def test_get_show_page
    get :show, id: @post
    assert_response :success
    assert_kind_of String, assigns(:post).title
    assert_kind_of String, assigns(:post).body
  end

  test "should create post" do
log_in(@user)
    assert_difference('Post.count',1) do
      post :create,  post: {  title: @post.title,body: @post.body, user_id: @user.id }
    end
    assert_redirected_to post_path(assigns(:post))
  end
end
