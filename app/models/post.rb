class Post
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations

  attr_accessor :blog, :title, :body, :pubdate

  validates :title, presence: true

  def initialize(attrs = {})
    attrs.each do |k,v| send("#{k}=", v) end
  end

  def publish(clock=DateTime)
    self.pubdate = clock.now
    blog.add_entry(self)
  end

  def persisted?
    false
  end
end
