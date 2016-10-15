class Comment < ActiveRecord::Base
  belongs_to :post
  validates :text , length: { minimum: 5, maximum:30}
  def self.latest_four
    order(created_at: :desc).limit(4)
  end
end
