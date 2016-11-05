require "test_helper"

class NewTest < ActionDispatch::IntegrationTest
  fixtures :posts, :users
  #include Authorization

  def setup
    @user= users(:user1)

  end


test "login with valid information" do
  x = @user.mail

  get new_session_path
  post session_path, params: { session: { email:  @user.email,
                                        password: 'password'
                                        } }
  assert_redirected_to @user
 end

 end
