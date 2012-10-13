class Post < ActiveRecord::Base
  belongs_to :user
  has_many :tags

  attr_accessible :body, :title, :tags_attributes

  accepts_nested_attributes_for :tags
end
