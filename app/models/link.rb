class Link < ApplicationRecord

  has_many :clicks

  validates_uniqueness_of :slug
  validates_presence_of   :slug, :url

  before_validation do
    length = ENV['LINK_LENGTH'] || 6
    self.slug = (Digest::MD5.hexdigest( (0...31).map { (65 + rand(26)).chr }.join ))[0...length.to_i] if self.slug.to_s.empty?
    self.slug = self.slug.to_s.downcase # force downcase
  end

end
