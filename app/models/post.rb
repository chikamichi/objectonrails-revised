class Post
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations

  attr_accessor :blog, :title, :body, :image_url, :pubdate

  validates :title, presence: true

  def initialize(attrs = {})
    attrs.each do |k,v| send("#{k}=", v) end
  end

  def publish(clock=DateTime)
    return false unless valid?
    self.pubdate = clock.now
    blog.add_entry(self)
  end

  def persisted?
    false
  end

  def human_name
    self.class.model_name.human
  end
end
