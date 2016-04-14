require 'minitest/autorun'
require_relative '../spec_helper_lite'
require_relative '../../app/helpers/exhibits_helper'

SpecHelpers.stub_class 'PicturePostExhibit'
SpecHelpers.stub_class 'TextPostExhibit'
SpecHelpers.stub_class 'Post'

describe ExhibitsHelper do
  subject { Object.new.extend(ExhibitsHelper) }
  let(:context) { stub! }

  it 'decorates picture posts with a PicturePostExhibit' do
    post = Post.new
    stub(post).picture? { true }
    # Do *not* use .must_be_same_as on the returned value from exhibit, as it is
    # exposed as being an instance of the decorated class. One must check the
    # actual class with .class and compare with the expected decorator.
    subject.exhibit(post, context).class.must_equal(PicturePostExhibit)
  end

  it 'decorates text posts with a TextPostExhibit' do
    post = Post.new
    stub(post).picture? { false }
    subject.exhibit(post, context).class.must_equal(TextPostExhibit)
  end

  it "leaves objects it doesn't know about alone" do
    model = Object.new
    subject.exhibit(model, context).must_be_same_as(model)
  end
end
