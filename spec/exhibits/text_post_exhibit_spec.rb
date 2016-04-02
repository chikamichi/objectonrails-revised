require 'minitest/autorun'
require_relative '../spec_helper_lite'
require_relative '../../app/exhibits/text_post_exhibit'

describe TextPostExhibit do
  let(:post) {
    OpenStruct.new(
      title: 'TITLE',
      body: 'BODY',
      pubdate: 'PUBDATE'
    )
  }
  let(:context) { stub! }
  subject { TextPostExhibit.new(post, context) }

  it 'delegates method calls to post' do
    subject.title.must_equal('TITLE')
    subject.body.must_equal('BODY')
    subject.pubdate.must_equal('PUBDATE')
  end

  it 'renders itself with the appropriate partial' do
    mock(context).render(
      partial: '/posts/text_body',
      locals: {post: subject}
    ) { 'THE_HTML' }
    subject.render_body.must_equal('THE_HTML')
  end
end
