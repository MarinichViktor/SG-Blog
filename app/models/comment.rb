class Comment < ActiveRecord::Base
  belongs_to :post
  validates :text , length: { minimum: 5, maximum:30}
  def self.first_two
    order(created_at: :asc).limit(2)
  end
end
