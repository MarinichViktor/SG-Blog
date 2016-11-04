class User < ActiveRecord::Base
  include ApplicationHelper
  before_save { self.email = email.downcase }
  before_create :confirmation_token
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
  def email_activate
    self.email_confirm_status = true
    self.confirm_token = nil
    save!(:validate => false)
  end
  private
  def confirmation_token
    if self.confirm_token.blank?
      self.confirm_token = secure_random_str
    end
  end

  def self.secure_random_str
    SecureRandom.urlsafe_base64.to_s
  end

  def self.bcrypt_str(string,cost=10)
    BCrypt::Password.create(string,cost: cost)
  end

end
