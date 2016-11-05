require 'test_helper'

class UserMailerTest < ActionMailer::TestCase

  def test_registration_confirmation
    user = users(:user2)
    user.confirm_token = User.secure_random_str
    mail = UserMailer.registration_confirmation(user)
    assert_equal "Registration Confirmation", mail.subject
    assert_equal [user.email], mail.to
    assert_equal ["noreply@example.com"], mail.from
    assert_match user.name,               mail.body.encoded
    assert_match user.confirm_token,   mail.body.encoded
    assert_match CGI.escape(user.email),  mail.body.encoded
  end

  def test_password_reset
    user = users(:user2)
    user.generate_reset_token
    mail = UserMailer.password_reset(user)
    assert_equal "Password Reset", mail.subject
    assert_equal [user.email], mail.to
    assert_equal ["noreply@example.com"], mail.from
    assert_match user.name,               mail.body.encoded
    assert_match user.reset_token,   mail.body.encoded
    assert_match CGI.escape(user.email),  mail.body.encoded
  end

end
