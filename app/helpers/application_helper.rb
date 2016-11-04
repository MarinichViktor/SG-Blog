module ApplicationHelper
  def secure_random_str
    SecureRandom.urlsafe_base64.to_s
  end
  def bcrypt_str(string)
    BCrypt::Password.create(string)
  end
end
