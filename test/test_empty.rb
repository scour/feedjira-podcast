require_relative "minitest_helper"

class TestEmpty < Minitest::Test
  describe "Empty Feed" do
    before do
      @empty_file = File.open(File.expand_path("../fixtures/empty.rss", __FILE__), "r")
      @empty_xml = @empty_file.read
      @feed = Feedjira::Feed.parse_with(Feedjira::Parser::Podcast, @empty_xml)
      @item = @feed.items.first
    end

    it "channel required" do
      assert_nil @feed.link
      assert_nil @feed.title
      assert_nil @feed.description
    end

    it "channel optional" do
      assert_nil @feed.language
      assert_nil @feed.copyright
      assert_nil @feed.managing_editor
      assert_nil @feed.web_master
      assert_nil @feed.pub_date
      assert_nil @feed.last_build_date
      assert_equal [], @feed.categories
      assert_nil @feed.generator
      assert_nil @feed.docs
      assert @feed.cloud
      assert_nil @feed.cloud.domain
      assert_nil @feed.cloud.port
      assert_nil @feed.cloud.path
      assert_nil @feed.cloud.register_procedure
      assert_nil @feed.cloud.protocol
      assert_nil @feed.ttl
      assert @feed.image
      assert_nil @feed.image.url
      assert_nil @feed.image.title
      assert_nil @feed.image.link
      assert_nil @feed.image.width
      assert_nil @feed.image.height
      assert_nil @feed.image.description
      assert_nil @feed.rating
      assert @feed.text_input
      assert_nil @feed.text_input.title
      assert_nil @feed.text_input.description
      assert_nil @feed.text_input.name
      assert_nil @feed.text_input.link
      assert @feed.skip
      assert_equal [], @feed.skip.hours
      assert_equal [], @feed.skip.days
    end

    it "channel apple" do
      assert @feed.itunes
      assert_nil @feed.itunes.author
      assert_equal false, @feed.itunes.block?
      assert_equal [], @feed.itunes.categories
      assert @feed.itunes.image
      assert_nil @feed.itunes.image.href
      assert_equal false, @feed.itunes.explicit?
      assert_equal false, @feed.itunes.clean?
      assert_equal false, @feed.itunes.complete?
      assert_nil @feed.itunes.new_feed_url
      assert @feed.itunes.owner
      assert_nil @feed.itunes.owner.email
      assert_nil @feed.itunes.owner.name
      assert_nil @feed.itunes.subtitle
      assert_nil @feed.itunes.summary
      assert_equal [], @feed.itunes.keywords
    end

    it "channel feedburner" do
      assert @feed.feedburner
      assert @feed.feedburner.info
      assert_nil @feed.feedburner.info.uri
    end

    it "channel atom" do
      assert @feed.atom
      assert @feed.atom.link
      assert @feed.atom.link.self
      assert_nil @feed.atom.link.self.href
      assert_nil @feed.atom.link.self.rel
      assert_nil @feed.atom.link.self.type
      assert @feed.atom.link.hub
      assert_nil @feed.atom.link.hub.href
      assert_nil @feed.atom.link.hub.rel
      assert_nil @feed.atom.link.hub.type
    end

    it "item required" do
      assert_nil @item.title
      assert_nil @item.description
    end

    it "item optional" do
      assert_nil @item.link
      assert_nil @item.author
      assert_equal [], @item.categories
      assert_nil @item.comments
      assert @item.enclosure
      assert_nil @item.enclosure.url
      assert_nil @item.enclosure.length
      assert_nil @item.enclosure.type
      assert @item.guid
      assert_nil @item.guid.guid
      assert_equal false, @item.guid.perma_link?
      assert_nil @item.pub_date
      assert @item.source
      assert_nil @item.source.name
      assert_nil @item.source.url
    end

    it "item dublin" do
      assert @item.dc
      assert_nil @item.dc.creator
    end

    it "item content" do
      assert @item.content
      assert_nil @item.content.encoded
    end

    it "item apple" do
      assert @item.itunes
      assert_nil @item.itunes.author
      assert_equal false, @item.itunes.block?
      assert @item.itunes.image
      assert_nil @item.itunes.image.href
      assert_nil @item.itunes.duration
      assert_equal false, @item.itunes.explicit?
      assert_equal false, @item.itunes.clean?
      assert_equal false, @item.itunes.closed_captioned?
      assert_nil @item.itunes.order
      assert_nil @item.itunes.subtitle
      assert_nil @item.itunes.summary
    end
  end
end
