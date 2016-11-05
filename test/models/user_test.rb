require 'test_helper'
class UserTest < ActiveSupport::TestCase
  fixtures :users

  def setup
    @user= users(:user1)
    @params = {name: "User1",email: "mail@ukr.net",city: "new york usa",password: "aaaaaa",password_confirmation: "aaaaaa"}
  end

  def test_user_with_valid_values
    user = User.new(@params)
    assert user.save
  end

  def test_user_with_invalid_email
    @params[:email]= ""
    user = User.new(@params)
    assert_not user.save
    @params[:email]= "mail.ukr.net"
    user = User.new(@params)
    assert_not user.save
  end

  def test_user_with_invalid_name
    @params[:name]= ""
    user = User.new(@params)
    assert_not user.save
    @params[:name]= "A"
    user = User.new(@params)
    assert_not user.save
  end

  def test_user_with_invalid_city
    @params[:city]= ""
    user = User.new(@params)
    assert_not user.save
  end

end
