class Post < ActiveRecord::Base
 validates :title , length: { minimum: 5 , maximum: 30}
 validates :body , length: { minimum: 30}
 validates_format_of :title,  :with => /\A[a-zA-Z\s\.\!\?]+\Z/
end
