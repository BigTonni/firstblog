class Comment < ActiveRecord::Base
  attr_accessible :body, :post_id, :commenter
  belongs_to :post
  validates :body, :presence => true
  validates :commenter, :presence => true
end
