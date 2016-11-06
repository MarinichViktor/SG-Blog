require "test_helper"

class PostsControllerTest < ActionController::TestCase
fixtures :users,:posts

  def  setup
    @user=users(:user1)
    @post=posts(:one)
  end

  def test_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:posts)
    assert_select "div.col-sm-4" do
      assert_select "div.thumbnail",9
    end
  end


  def test_get_show_post
    get :show, id: @post
    assert_response :success
    assert_kind_of String, assigns(:post).title
    assert_kind_of String, assigns(:post).body
    assert_select 'div.profile-container'
    assert_select 'div.post-body'
    assert_template 'posts/show'
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
    assert_not_nil assigns(:post).title
    assert_not_nil assigns(:post).body
    assert_template 'posts/edit'
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
