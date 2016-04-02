require 'minitest/autorun'
require_relative '../spec_helper_lite'
require_relative '../../app/exhibits/picture_post_exhibit'

describe PicturePostExhibit do
  let(:post) {
    OpenStruct.new(
      title: 'TITLE',
      body: 'BODY',
      pubdate: 'PUBDATE'
    )
  }
  let(:context) { stub! }
  subject { PicturePostExhibit.new(post, context) }

  it 'delegates method calls to post' do
    subject.title.must_equal('TITLE')
    subject.body.must_equal('BODY')
    subject.pubdate.must_equal('PUBDATE')
  end

  it 'renders itself with the appropriate partial' do
    mock(context).render(
      partial: '/posts/picture_body',
      locals: {post: subject}
    ) { 'THE_HTML' }
    subject.render_body.must_equal('THE_HTML')
  end
end
