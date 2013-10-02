class Post < ActiveRecord::Base
  belongs_to :user
  has_many :tags, autosave: true
  
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

  # before_save hook to ensure that existing tags are 
  # looked up rather than re-created
  # See http://stackoverflow.com/questions/9024745
  def autosave_associated_records_for_tags
    valid_tags = []

    self.tags.each do |tag|
      if existing_tag = Tag.where(name: tag.name).first
        valid_tags << existing_tag
      else
        valid_tags << tag
      end
    end

    self.tags << valid_tags
  end
end
