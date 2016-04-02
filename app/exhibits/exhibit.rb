require 'delegate'

class Exhibit < SimpleDelegator
  def self.exhibits
    [
      TextPostExhibit,
      PicturePostExhibit
    ]
  end

  def initialize(model, context)
    @context = context
    super(model)
  end

  def to_model
    __getobj__
  end

  def self.exhibit(object, context)
    exhibits.inject(object) do |object, exhibit|
      exhibit.exhibit_if_applicable(object, context)
    end
  end

  # Contract: subclasses to implement this.
  def applicable_to?(object)
    false
  end

  private

  def self.exhibit_if_applicable(object, context)
    if applicable_to?(object)
      new(object, context)
    else
      object
    end
  end
end
