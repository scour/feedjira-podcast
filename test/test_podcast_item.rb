require_relative "minitest_helper"

class TestPodcastItem < Minitest::Test
  describe "Parser" do
    before do
      @full_file = File.open(File.expand_path("../fixtures/full.rss", __FILE__), "r")
      @full_xml = @full_file.read
      @feed = Feedjira::Feed.parse_with(Feedjira::Parser::Podcast, @full_xml)
    end

    it "finds some items" do
      assert_operator @feed.items.count, :>, 0
    end

    describe "parsing required item elements" do
      it "finds the title" do
        assert_equal "item_title", @feed.items[0].title
      end

      it "finds the description" do
        assert_equal "item_description", @feed.items[0].description
      end
    end

    describe "parsing optional item elements" do
      it "finds the link" do
        uri = Addressable::URI.parse("http://example.com/item/link")
        assert_equal uri, @feed.items[0].link
      end

      it "finds the author" do
        assert_equal "item_author", @feed.items[0].author
      end

      it "finds the categories" do
        assert @feed.items[0].categories
      end

      it "finds several categories" do
        assert_operator @feed.items[0].categories.count, :>, 1
      end

      it "ignores duplicate categories" do
        assert_equal 2, @feed.items[0].categories.count
      end

      it "always gets array for categories" do
        assert_equal Array, @feed.items[1].categories.class
      end

      it "finds the comments" do
        uri = Addressable::URI.parse("http://example.com/item/comments")
        assert_equal uri, @feed.items[0].comments
      end

      it "finds the enclosure url" do
        uri = Addressable::URI.parse("http://example.com/item/enclosure/url")
        assert_equal uri, @feed.items[0].enclosure.url
      end

      it "finds the enclosure length" do
        assert_equal 42, @feed.items[0].enclosure.length
      end

      it "finds the enclosure type" do
        assert_equal "audio/mpeg", @feed.items[0].enclosure.type
      end

      it "finds the guid" do
        uri = Addressable::URI.parse("http://example.com/item/guid")
        assert_equal uri, @feed.items[0].guid.guid
      end

      it "finds the perma link" do
        assert_equal true, @feed.items[0].guid.perma_link?
      end

      it "finds the pub date" do
        t = Time.at(0)
        assert_equal t, @feed.items[0].pub_date
      end

      it "finds the source url" do
        uri = Addressable::URI.parse("http://example.com/item/source")
        assert_equal uri, @feed.items[0].source.url
      end

      it "finds the source name" do
        assert_equal "source_name", @feed.items[0].source.name
      end
    end

    describe "parsing itunes ns item elements" do
      it "finds the author" do
        assert_equal "itunes_author", @feed.items[0].itunes.author
      end

      it "finds the block" do
        assert_equal true, @feed.items[0].itunes.block?
      end

      it "finds the image" do
        uri = Addressable::URI.parse("http://example.com/item/itunes/image/href")
        assert_equal uri, @feed.items[0].itunes.image.href
      end

      it "finds the duration" do
        assert_equal 5000, @feed.items[0].itunes.duration
        assert_equal 100, @feed.items[1].itunes.duration
        assert_equal 30, @feed.items[2].itunes.duration
      end

      it "finds the explicit" do
        assert_equal false, @feed.items[0].itunes.explicit?
      end

      it "finds the clean" do
        assert_equal true, @feed.items[0].itunes.clean?
      end

      it "finds the closed captioned" do
        assert_equal true, @feed.items[0].itunes.closed_captioned?
      end

      it "finds the order" do
        assert_equal 42, @feed.items[0].itunes.order
      end

      it "finds the subtitle" do
        assert_equal "itunes_subtitle", @feed.items[0].itunes.subtitle
      end

      it "finds the summary" do
        assert_equal "itunes_summary", @feed.items[0].itunes.summary
      end

      it "finds some keywords" do
        assert_equal 3, @feed.items[0].itunes.keywords.count
      end

      it "finds the first keywords" do
        assert_equal "keyword1", @feed.items[0].itunes.keywords[0]
      end
    end

    describe "parsing dublin core ns item elements" do
      it "finds the creator" do
        assert_equal "dc_creator", @feed.items[0].dc.creator
      end
    end

    describe "parsing content ns item elements" do
      it "finds the content encoded" do
        content = "<p>content <b>encoded</b></p>"
        assert_equal content, @feed.items[0].content.encoded
      end
    end
  end
end
