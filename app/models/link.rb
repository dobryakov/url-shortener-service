class Link < ApplicationRecord

  has_many :clicks

  validates_uniqueness_of :slug
  validates_presence_of   :slug, :url

end
