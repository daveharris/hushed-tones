class Post < ActiveRecord::Base
  belongs_to :user
  has_many :tags

  attr_accessible :body, :title, :tags_attributes, :user
  accepts_nested_attributes_for :tags

  validates :title, :body, :user_id, presence: true

  def display_date
    self.created_at.localtime.strftime('%a %b %d %I:%M%p')
  end
end
