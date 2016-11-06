class User < ActiveRecord::Base
  include ApplicationHelper
  before_save { self.email = email.downcase }
  before_create :confirmation_token
  after_save :check_geocodes
  has_many :posts
  has_many :comments, dependent: :destroy
  validates :name , length: { minimum: 4 , maximum: 12}
  validates :city , presence: true
  validates :email, presence: true, uniqueness: {case_sensitive: false}, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i}
  validates :password , length: { minimum: 6 }
  has_secure_password
  mount_uploader :profile_img, ImageUploader
  geocoded_by :city
  after_validation :geocode
  after_destroy :delete_user_image_folder

  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)

  end

  def email_activate
    self.email_confirm_status = true
    self.confirm_token = nil
    save!(:validate => false)
  end

  def generate_reset_token
    self.reset_token = User.secure_random_str
    self.token_created =  Time.now
    save!(:validate => false)
  end

  def is_reset_token?
    if ((Time.now-self.token_created)/60).round >120
      self.update_attribute(:reset_token,nil)
      false
    else
      true
    end
  end
  private

  def delete_user_image_folder
      FileUtils.remove_dir(File.join(Rails.root, File.join( 'public' ,'uploads','user','profile_img',"#{self.id}")), :force => true)
  end

  def check_geocodes
    return true if self.latitude
    self.latitude = 49.839683
    self.longitude = 24.029717
    save!(:validate => false)
  end

  def confirmation_token
    if self.confirm_token.blank?
      self.confirm_token = User.secure_random_str
    end
  end

  def self.secure_random_str
    SecureRandom.urlsafe_base64.to_s
  end

  def self.bcrypt_str(string,cost=10)
    BCrypt::Password.create(string,cost: cost)
  end

end
