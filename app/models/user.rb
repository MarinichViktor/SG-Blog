class User < ActiveRecord::Base
  has_many :posts
  validates :name , length: { minimum: 4 , maximum: 12}
  validates :email, presence: true, uniqueness: {case_sensitive: false}, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i}
  validates :password , length: { minimum: 6 }
  has_secure_password



  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)

  end

end
