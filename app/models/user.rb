class User < ActiveRecord::Base

  validates :name , length: { minimum: 4 , maximum: 12}
  validates :email, presence: true, uniqueness: {case_sensitive: false}, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i}
  validates :password , length: { minimum: 6 }
  has_secure_password
end
