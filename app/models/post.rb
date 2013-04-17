class Post < ActiveRecord::Base
  belongs_to :user
  has_many :tags

  attr_accessible :body, :title, :tags_attributes, :user
  accepts_nested_attributes_for :tags

  validates :title, :body, :user_id, presence: true
end
