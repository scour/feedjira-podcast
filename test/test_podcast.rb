require_relative "minitest_helper"

class TestPodcast < Minitest::Test
  describe "Parser" do
    before do
      @_99pi_file = File.open(File.expand_path("../fixtures/99pi.rss", __FILE__), "r")
      @_99pi_xml = @_99pi_file.read
      @_99pi_feed = Feedjira::Feed.parse_with(Feedjira::Parser::Podcast, @_99pi_xml)

      @full_file = File.open(File.expand_path("../fixtures/full.rss", __FILE__), "r")
      @full_xml = @full_file.read
      @feed = Feedjira::Feed.parse_with(Feedjira::Parser::Podcast, @full_xml)

      @bad_dates_file = File.open(File.expand_path("../fixtures/bad_dates.rss", __FILE__), "r")
      @bad_dates_xml = @bad_dates_file.read
      @bad_dates_feed = Feedjira::Feed.parse_with(Feedjira::Parser::Podcast, @bad_dates_xml)

      @blog_file = File.open(File.expand_path("../fixtures/99pi.rss", __FILE__), "r")
      @blog_xml = @blog_file.read
    end

    it "is the parser used for podcast feeds" do
      feed = Feedjira::Feed.parse(@_99pi_xml)

      assert_equal Feedjira::Parser::Podcast, feed.class
    end

    it "parses podcast feeds" do
      feed = Feedjira::Feed.parse_with(Feedjira::Parser::Podcast, @_99pi_xml)

      assert feed
    end

    it "does not parse non-RSS files" do
      # feed = Feedjira::Feed.parse(@blog_xml)
      # TODO
      # assert_equal 1, feed.class
    end

    describe "parsing required channel elements" do
      it "finds the link" do
        uri = Addressable::URI.parse("http://example.com/channel/link")
        assert_equal uri, @feed.link
      end

      it "finds the title" do
        assert_equal "channel_title", @feed.title
      end

      it "finds the description" do
        assert_equal "channel_description", @feed.description
      end
    end

    describe "parsing optional channel elements" do
      it "finds the language" do
        assert_equal "en-us", @feed.language
      end

      it "finds the copyright" do
        assert_equal "Copyright © 2015 Example Co.", @feed.copyright
      end

      it "finds the managing editor" do
        assert_equal "editor@example.com (Alice Doe)", @feed.managing_editor
      end

      it "finds the web master" do
        assert_equal "webMaster@example.com (Bob Doe)", @feed.web_master
      end

      it "finds the pub date" do
        t = Time.at(0)
        assert_equal t, @feed.pub_date
      end

      it "does not break with bad dates" do
        assert_equal nil, @bad_dates_feed.pub_date
        assert_equal nil, @bad_dates_feed.last_build_date
        assert_equal nil, @bad_dates_feed.items[0].pub_date
      end

      it "finds the last build date" do
        t = Time.at(0)
        assert_equal t, @feed.last_build_date
      end

      it "finds the categories" do
        assert @feed.categories
      end

      it "finds several categories" do
        assert_operator @feed.categories.count, :>, 1
      end

      it "ignores duplicate categories" do
        assert_equal 2, @feed.categories.count
      end

      it "finds the generator" do
        assert_equal "channel_generator", @feed.generator
      end

      # it "finds the cloud" do
      #   assert_equal "channel_generator", @feed.generator
      # end

      it "finds the ttl" do
        assert_equal 42, @feed.ttl
      end

      it "finds the docs" do
        uri = Addressable::URI.parse("http://blogs.law.harvard.edu/tech/rss")
        assert_equal uri, @feed.docs
      end

      it "finds the image url" do
        uri = Addressable::URI.parse("http://example.com/channel/image/url")
        assert_equal uri, @feed.image.url
      end

      it "finds the image title" do
        assert_equal "channel_image_title", @feed.image.title
      end

      it "finds the image link" do
        uri = Addressable::URI.parse("http://example.com/channel/image/link")
        assert_equal uri, @feed.image.link
      end

      it "finds the image width" do
        assert_equal 42, @feed.image.width
      end

      it "finds the image height" do
        assert_equal 42, @feed.image.height
      end

      it "finds the image description" do
        assert_equal "channel_image_description", @feed.image.description
      end

      # it "finds the rating" do
      #   assert_equal 42, @feed.image.height
      # end

      it "finds the text input" do
        uri = Addressable::URI.parse("http://example.com/channel/text_input/link")

        assert_equal "text_input_title", @feed.text_input.title
        assert_equal "text_input_description", @feed.text_input.description
        assert_equal "text_input_name", @feed.text_input.name
        assert_equal uri, @feed.text_input.link
      end

      it "finds the skip hours" do
        assert_equal 4, @feed.skip.hours.count
        assert_equal [0, 1, 22, 23], @feed.skip.hours
      end

      it "finds the skip days" do
        assert_equal 2, @feed.skip.days.count
        assert @feed.skip.days.include?(:Saturday)
        assert @feed.skip.days.include?(:Sunday)
      end
    end

    describe "parsing atom channel elements" do
      it "finds the href for link with self rel" do
        uri = Addressable::URI.parse("http://example.com/channel/atom/link/self/href")
        assert_equal uri, @feed.atom.link.self.href
      end

      it "finds the rel for link with self rel" do
        assert_equal "self", @feed.atom.link.self.rel
      end

      it "finds the type for link with self rel" do
        assert_equal "application/rss+xml", @feed.atom.link.self.type
      end

      it "finds the href for link with hub rel" do
        uri = Addressable::URI.parse("http://example.com/channel/atom/link/hub/href")
        assert_equal uri, @feed.atom.link.hub.href
      end

      it "finds the rel for link with hub rel" do
        assert_equal "hub", @feed.atom.link.hub.rel
      end

      it "finds the type for link with hub rel" do
        assert_equal nil, @feed.atom.link.hub.type
      end
    end

    describe "parsing feedburner channel elements" do
      it "finds the feedburner info uri" do
        uri = Addressable::URI.parse("feedburner_info_uri")
        assert_equal uri, @feed.feedburner.info.uri
      end
    end

    describe "parsing apple channel elements" do
      it "finds the author" do
        assert_equal "itunes_author", @feed.itunes.author
      end

      it "finds the block" do
        assert_equal true, @feed.itunes.block?
      end

      # it "finds the category" do
      #   assert_equal "itunes_author", @feed.itunes.author
      # end

      it "finds some categories" do
        assert_operator @feed.itunes.categories.count, :>, 1
      end

      it "gets the top-level categories" do
        assert_equal ["first_category", "second_category", "third_category"], @feed.itunes.categories.map(&:text)
      end

      it "gets the sub category" do
        # TODO
        # assert_equal "first_sub_category", @feed.itunes.categories[0].subcategory
      end

      it "finds the image" do
        uri = Addressable::URI.parse("http://example.com/channel/itunes/image/href")
        assert_equal uri, @feed.itunes.image.href
      end

      it "finds the explicit" do
        assert_equal false, @feed.itunes.explicit?
      end

      it "finds the clean" do
        assert_equal true, @feed.itunes.clean?
      end

      it "finds the complete" do
        assert_equal true, @feed.itunes.complete?
      end

      it "finds the new feed url" do
        uri = Addressable::URI.parse("http://example.com/channel/itunes/new-feed-url")
        assert_equal uri, @feed.itunes.new_feed_url
      end

      it "finds the owner email" do
        assert_equal "itunes_owner@example.com", @feed.itunes.owner.email
      end

      it "finds the owner name" do
        assert_equal "itunes_owner_name", @feed.itunes.owner.name
      end

      it "finds the subtitle" do
        assert_equal "itunes_subtitle", @feed.itunes.subtitle
      end

      it "finds the summary" do
        assert_equal "itunes_summary", @feed.itunes.summary
      end

      it "finds some keywords" do
        assert_equal 3, @feed.itunes.keywords.count
      end

      it "finds the first keywords" do
        assert_equal "keyword1", @feed.itunes.keywords[0]
      end
    end
  end
end
