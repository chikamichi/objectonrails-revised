require 'minitest/autorun'
require_relative '../spec_helper_lite'
require 'active_model'
require_relative '../../app/models/post'

describe Post do
  subject { Post.new(title: 'TITLE') }
  let(:ar) { subject }

  it "starts with some blank attributes" do
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

  it 'is not valid with a blank title' do
    [nil, "", ''].each do |bad_title|
      subject.title = bad_title
      subject.wont_be :valid?
    end
  end

  it 'is valid with a non-blank title' do
    subject.title = 'x'
    subject.must_be :valid?
  end

  describe "with an attributes hash passed to the initializer" do
    subject { Post.new(title: "my title", body: "my body") }

    it "supports setting custom attributes" do
      subject.title.must_equal "my title"
      subject.body.must_equal "my body"
    end
  end

  describe "#pubdate" do
    describe "before publishing" do
      it "is blank" do
        subject.pubdate.must_be_nil
      end
    end

    describe "after publishing" do
      before do
        @now = DateTime.parse("2016-03-31T09:33")
        clock = Object.new
        stub(clock).now { @now }
        stub(subject).blog.stub!.add_entry(subject)
        subject.publish(clock)
      end

      it "is the current time" do
        subject.pubdate.must_equal @now
      end
    end
  end

  describe '#picture?' do
    it 'is true when the post has a picture URL' do
      subject.image_url = 'http://example.org/foo.png'
      assert(subject.picture?)
    end

    it 'is false when the post has no picture URL' do
      subject.image_url = ''
      refute(subject.picture?)
    end
  end

  describe "#publish" do
    describe "given a valid post" do
      it "adds the post to the blog" do
        mock(subject).blog.stub!.add_entry(subject)
        subject.publish
      end
    end

    describe "given an invalid post" do
      before do
        stub(ar).valid? { false }
      end

      it "won't add the post to the blog" do
        dont_allow(subject.blog).add_entry
        subject.publish
      end

      it "returns false" do
        refute(subject.publish)
      end
    end
  end
end
