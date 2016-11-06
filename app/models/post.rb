class Post < ActiveRecord::Base
 mount_uploader :image, ImageUploader
 has_many :comments, dependent: :destroy
 belongs_to :user
 validates :user, presence: true
 validates :title , length: { minimum: 5 , maximum: 30}
 validates :body , length: { minimum: 200}
 after_destroy :delete_post_image_folder


 def self.latest_nine
   order(created_at: :desc).limit(9)
 end
 private
 def delete_post_image_folder
     FileUtils.remove_dir(File.join(Rails.root, File.join( 'public' ,'uploads','post','image',"#{self.id}")), :force => true)
 end
end
