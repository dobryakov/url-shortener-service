class Visitor < ApplicationRecord

  validates_uniqueness_of :hash_string
  validates_presence_of   :hash_string

  has_many :clicks

  before_validation do
    self.hash_string = Digest::MD5.hexdigest( (0...31).map { (65 + rand(26)).chr }.join ) unless self.hash_string
  end

end
