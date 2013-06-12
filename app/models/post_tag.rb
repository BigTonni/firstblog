class PostTag < ActiveRecord::Base
  #self.table_name = "posts_tags"
  attr_accessible :post_id, :tag_id

  belongs_to :post
  belongs_to :tag
end