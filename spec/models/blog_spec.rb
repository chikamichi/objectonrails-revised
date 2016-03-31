require 'minitest/autorun'
require_relative '../../app/models/blog'
require 'ostruct'

describe Blog do
  subject { Blog.new }

  it "has no entries" do
    subject.entries.must_be_empty
  end

  describe "#new_post" do
    before do
      @new_post = OpenStruct.new
      subject.post_source = ->{ @new_post }
    end

    it "returns a new post" do
      subject.new_post.must_equal @new_post
    end

    it "sets the post's blog reference to itself" do
      subject.new_post.blog.must_equal(subject)
    end
  end
end
