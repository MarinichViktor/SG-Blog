class Comment < ActiveRecord::Base
  belongs_to :post
  validates :text , length: { minimum: 2}
  validates_format_of :text, :without => /(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?/ix
  validates_format_of :text, :without => /First post!/i
  def self.first_two
    order(created_at: :asc).limit(2)
  end
end
