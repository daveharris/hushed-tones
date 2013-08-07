class Post < ActiveRecord::Base
  belongs_to :user
  has_many :tags
  
  mount_uploader :picture, PictureUploader

  attr_accessible :body, :title, :tags_attributes, :user, :picture
  accepts_nested_attributes_for :tags, reject_if: :all_blank, allow_destroy: true

  validates :title, :body, :user_id, :slug, presence: true

  before_validation :slugify

  def body_html
    RedCloth.new(self.body).to_html if self.body
  end

  def display_date
    self.created_at.localtime.strftime('%a %b %d %I:%M%p')
  end

  def to_param
    self.slug
  end

  private

  def slugify
    self.slug = self.title.parameterize
  end
end
