require_relative 'minitest_helper'

class TestPodcast < Minitest::Test
  describe 'Parser' do
    before do
      @_99pi_file = File.open(File.expand_path('../fixtures/99pi.rss', __FILE__), 'r')
      @_99pi_xml = @_99pi_file.read
      @_99pi_feed = Feedjira::Feed.parse_with(Feedjira::Parser::Podcast, @_99pi_xml)

      @full_file = File.open(File.expand_path('../fixtures/full.rss', __FILE__), 'r')
      @full_xml = @full_file.read
      @feed = Feedjira::Feed.parse_with(Feedjira::Parser::Podcast, @full_xml)

      @blog_file = File.open(File.expand_path('../fixtures/99pi.rss', __FILE__), 'r')
      @blog_xml = @blog_file.read
    end

    it 'is the parser used for podcast feeds' do
      feed = Feedjira::Feed.parse(@_99pi_xml)

      assert_equal Feedjira::Parser::Podcast, feed.class
    end

    it 'parses podcast feeds' do
      feed = Feedjira::Feed.parse_with(Feedjira::Parser::Podcast, @_99pi_xml)

      assert feed
    end

    it 'does not parse non-RSS files' do
      feed = Feedjira::Feed.parse(@blog_xml)

      # assert_equal 1, feed.class
    end

    describe 'parsing' do
      it 'finds the channel link' do
        uri = Addressable::URI.parse("http://example.com/channel/link")
        assert_equal uri, @feed.link
      end

      it 'finds the channel title' do
        assert_equal 'channel_title', @feed.title
      end
    end
  end
end
