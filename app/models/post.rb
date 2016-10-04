class Post < ActiveRecord::Base
 validates :title , length: { minimum: 5 , maximum: 30}
 validates :body , length: { minimum: 200}
end
