class Comment < ActiveRecord::Base
  belongs_to :post
  validates :text , length: { minimum: 5, maximum:30}
end
