class Comment < ActiveRecord::Base
  attr_accessible :body, :post_id, :commenter, :commentable_id, :commentable_type

  validates :body, :presence => true
  validates :body, :length => { :maximum => 1024 }
  validates :post_id, :presence => true
  validates :commenter, :presence => true

  belongs_to :post, :counter_cache => :comments_counter
  belongs_to :user
  belongs_to :commentable, :polymorphic => true
end
