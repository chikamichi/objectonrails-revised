require 'date'
require 'active_record'

class Post < ActiveRecord::Base
  attr_accessor :blog

  validates :title, presence: true

  def picture?
    image_url.present?
  end

  def publish(clock=DateTime)
    return false unless valid?
    self.pubdate = clock.now
    blog.add_entry(self)
  end
end
