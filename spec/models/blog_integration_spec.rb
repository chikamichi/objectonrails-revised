require 'minitest/autorun'
require_relative '../spec_helper_full'
require_relative '../../app/models/blog'

describe Blog do
  include SpecHelpers

  before do
    setup_database
  end

  subject { Blog.new }

  after do
    teardown_database
  end

  describe "#entries" do
    def make_entry_with_date(date)
      subject.new_post(pubdate: DateTime.parse(date), title: date)
    end

    it "is sorted in reverse-chronological order" do
      oldest = make_entry_with_date("2014-09-09")
      newest = make_entry_with_date("2016-04-04")
      middle = make_entry_with_date("2015-01-31")
      subject.add_entry(oldest)
      subject.add_entry(newest)
      subject.add_entry(middle)
      subject.entries.must_equal [newest, middle, oldest]
    end

    it 'is limited to 10 items' do
      10.times do |i|
        subject.add_entry(make_entry_with_date("2016-03-#{i+1}"))
      end
      oldest = make_entry_with_date('2015-03-02')
      subject.add_entry(oldest)
      subject.entries.size.must_equal(10)
      subject.entries.wont_include(oldest)
    end
  end
end
