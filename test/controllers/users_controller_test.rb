require "test_helper"

class UsersControllerTest < ActionController::TestCase
fixtures :users,:posts

  def  setup
    @user=users(:user1)
    @post=posts(:one)
  end

  def test_get_new
    get :new
    assert_response :success
  end

  def test_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
    assert_not_nil assigns(:hash)

  end
  def test_get_show_user
    get :show, id: @user
    assert_response :success
    assert_kind_of String, assigns(:user).name
    assert_kind_of String, assigns(:user).email
  end

  def test_create_user
    assert_difference('User.count',1) do
      post :create, user: { name: @user.name, city: @user.city, email: "pam12345@ukr.net",
         password: "password",password_confirmation: "password" }
    end
    assert_redirected_to user_path(User.last)
  end

  def test_update_user
    login(@user)
    name = @user.name
    patch :update, id: @user, user: { name:" new name", city: @user.city, email: "pam12345@ukr.net",
         password: "password",password_confirmation: "password" }
    assert_redirected_to user_path(@user)
    assert_not_equal assigns(:user).name, name
  end

  def test_edit_user_without_login
    get :edit, id: @user
    assert_redirected_to new_session_path
  end

  def test_edit_user
    login(@user)
    get :edit, id: @user
    assert_response :success
  end


end
