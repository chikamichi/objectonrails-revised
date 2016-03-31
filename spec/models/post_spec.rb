require 'minitest/autorun'
require_relative '../../app/models/post'

describe Post do
  subject { Post.new }

  it "starts with blank attributes" do
    subject.title.must_be_nil
    subject.body.must_be_nil
  end

  it "supports reading and writing a title" do
    subject.title = "foo"
    subject.title.must_equal "foo"
  end

  it "supports reading and writing a post body" do
    subject.body = "foo"
    subject.body.must_equal "foo"
  end

  it "supports reading and writing a blog reference" do
    blog = Object.new
    subject.blog = blog
    subject.blog.must_equal blog
  end

  describe "#publish" do
    before do
      subject.blog = Minitest::Mock.new
    end

    after do
      subject.blog.verify
    end

    it "adds the post to the blog" do
      subject.blog.expect :add_entry, nil, [subject]
      subject.publish
    end
  end
end