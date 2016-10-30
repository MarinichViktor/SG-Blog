class Post < ActiveRecord::Base
 mount_uploader :image, ImageUploader
 has_many :comments, dependent: :destroy
 validates :title , length: { minimum: 5 , maximum: 30}
 validates :body , length: { minimum: 200}
 def self.latest_five
   order(created_at: :desc).limit(5)
 end
end
