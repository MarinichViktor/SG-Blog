require "test_helper"

class NewTest < ActionDispatch::IntegrationTest
  fixtures :posts, :users
  #include Authorization

  def setup
    @user= users(:user2)

  end


test "login with valid information" do

  post session_path,  session: { email:  @user.email,
                                        password: 'password'
                                        }
  assert page.has_content?("You loged  in system.")
 end

 end
