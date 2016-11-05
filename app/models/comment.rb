class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user
  validates :post, presence: true
  validates :user, presence: true
  validates :text , length: { minimum: 2}
  validates_format_of :text, :without => /(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?/ix
  validates_format_of :text, :without => /First post!/i

end
