class Tag < ActiveRecord::Base
  attr_accessible :name
  validates :name, :presence => true,
            :uniqueness => true
  #belongs_to :post
  has_many :post_tags
  has_many :posts, :through => :post_tags
  #accepts_nested_attributes_for :posts,  :reject_if => proc { |attrs| attrs.all? { |k, v| v.blank? } }
end
