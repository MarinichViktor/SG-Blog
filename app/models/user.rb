class User < ActiveRecord::Base
  before_save { self.email = email.downcase }
  has_many :posts
  has_many :comments, dependent: :destroy
  validates :name , length: { minimum: 4 , maximum: 12}
  validates :email, presence: true, uniqueness: {case_sensitive: false}, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i}
  validates :password , length: { minimum: 6 }
  has_secure_password
  mount_uploader :profile_img, ImageUploader


  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)

  end

end
