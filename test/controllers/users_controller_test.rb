require "test_helper"

class UsersControllerTest < ActionController::TestCase
fixtures :users,:posts

  def  setup
    @user=users(:user1)
    @post=posts(:one)
  end

  def test_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:posts)
  end


  def test_get_show_post
    get :show, id: @post
    assert_response :success
    assert_kind_of String, assigns(:post).title
    assert_kind_of String, assigns(:post).body
  end

  def test_create_post
    login(@user)
    assert_difference('Post.count',1) do
      post :create, post: { body: @post.body, title: @post.title, user_id: @user.id }
    end
  end

  def test_get_edit_post
    login(@user)
    get :edit, id: @post
    assert_response :success
  end

  def test_update_post
    login(@user)
    title =@post.title
    patch :update,id: @post,  post: { body: @post.body, title: "x"*10, user_id: @user.id }
    assert_not_equal assigns(:post).title, title
  end

  def test_destroy_post
    login(@user)
    assert_difference('Post.count',-1) do
      delete :destroy, id: @user.posts.last.id
    end
  end
end
