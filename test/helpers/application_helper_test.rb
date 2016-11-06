require 'test_helper'
class ApplicationHelperTest < ActiveSupport::TestCase
  include ApplicationHelper
  fixtures :users

  def test_user_signed_in?
    @user=users(:user1)
    assert user_signed_in?
    @user=nil
    assert_not user_signed_in?
  end

  def test_is_a_current_user?
    @user=users(:user1)
    is_a_current_user?(users(:user2))
  end

  def current_user
    @user
  end

  def  test_sign_out
    current_user = @user
    sign_out
    assert_not current_user
  end

end
