require "test_helper"

class SessionsControllerTest < ActionController::TestCase
fixtures :users,:posts

  def setup
    @user=users(:user1)
    @post=posts(:one)
  end

  def test_get_new_session
    get :new
    assert_response :success
    assert_template 'sessions/new'
  end

  def test_create_session
    post :create, session: { email:  @user.email, password: 'password' }
    assert_redirected_to user_path(@user)
  end

  def test_destroy_session
    post :create, session: { email:  @user.email, password: 'password' }
    delete :destroy , session: { email:  @user.email, password: 'password' }
    assert_redirected_to root_path
  end
end
