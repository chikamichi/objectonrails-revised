require 'minitest/autorun'
require_relative '../spec_helper_lite'
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

    it "accepts an attribute hash on behalf on the post maker" do
      post_source = Object.new
      mock(post_source).call({x: 42, y: 'z'}) { @new_post }
      subject.post_source = post_source
      subject.new_post(x: 42, y: 'z')
    end
  end

  describe "#add_entry" do
    it "adds the entry to the blog" do
      entry = stub!
      subject.add_entry(entry)
      subject.entries.must_include(entry)
    end
  end

  describe "#entries" do
    def stub_entry_with_date(date)
      OpenStruct.new(pubdate: DateTime.parse(date))
    end

    it "is sorted in reverse-chronological order" do
      oldest = stub_entry_with_date("2014-09-09")
      newest = stub_entry_with_date("2016-04-04")
      middle = stub_entry_with_date("2015-01-31")
      subject.add_entry(oldest)
      subject.add_entry(newest)
      subject.add_entry(middle)
      subject.entries.must_equal [newest, middle, oldest]
    end
  end
end
