class Click < ApplicationRecord

  belongs_to :link, counter_cache: true
  belongs_to :visitor

  validates_presence_of :link, :visitor

end
