class Post < ActiveRecord::Base
  attr_accessible :body, :data, :title, :tags_attributes
  validates :body, :presence => true
  validates :title, :presence => true

  has_many :comments, :dependent => :destroy
  has_many :tags
  accepts_nested_attributes_for :tags, :allow_destroy => :true,
                                :reject_if => proc { |attrs| attrs.all? { |k, v| v.blank? } }

  scope :select, where("post NOT LIKE '%hidden%'")
end
