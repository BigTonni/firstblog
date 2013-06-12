class Post < ActiveRecord::Base
  attr_accessible :body, :data, :title, :user_id, :agree, :tags_attributes

  validates :body, :presence => true
  validates :title, :presence => true
  #validates :user_id, :presence => true

  belongs_to :user

  has_many :comments, :dependent => :destroy
  has_many :post_tags
  has_many :tags, :through => :post_tags
  accepts_nested_attributes_for :tags, :allow_destroy => :true,
                                :reject_if => proc { |attrs| attrs.all? { |k, v| v.blank? } }

  scope :not_hidden, where("title NOT LIKE '%hidden%'")
  scope :banning_to_approve, where("agree = 0")
  scope :user_agrees, where("agree = 1")
  scope :banning_warning, where("agree = 2")

  before_save :save_post
  before_update :save_post

  def save_post
    if tags_attributes
      self.tags = tags_attributes.map do |_, tag|
        Tag.find_or_create_by_name(tag[:name])
      end
    end
  end
end
