require 'delegate'

class Exhibit < SimpleDelegator
  def initialize(model, context)
    @context = context
    super(model)
  end

  def to_model
    __getobj__
  end
end
