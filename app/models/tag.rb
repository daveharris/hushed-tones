class Tag < ActiveRecord::Base
  has_and_belongs_to_many :post
  attr_accessible :name
end
