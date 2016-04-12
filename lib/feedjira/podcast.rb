require "feedjira"
require "addressable/uri"

require "feedjira/podcast/version"

require "feedjira/podcast/item/guid"
require "feedjira/podcast/item/source"

require "feedjira/podcast/item/required"
require "feedjira/podcast/item/optional"
require "feedjira/podcast/item/apple"
require "feedjira/podcast/item/dublin"
require "feedjira/podcast/item/content"

require "feedjira/podcast/channel/cloud"
require "feedjira/podcast/channel/image"
require "feedjira/podcast/channel/skip_hours"
require "feedjira/podcast/channel/skip_days"
require "feedjira/podcast/channel/text_input"
require "feedjira/podcast/channel/apple_owner"
require "feedjira/podcast/channel/apple_subcategory"
require "feedjira/podcast/channel/apple_category"

require "feedjira/podcast/channel/required"
require "feedjira/podcast/channel/optional"
require "feedjira/podcast/channel/atom"
require "feedjira/podcast/channel/feedburner"
require "feedjira/podcast/channel/apple"
require "feedjira/podcast/channel/syndication"
require "feedjira/podcast/channel/item"

require "feedjira/podcast/rss/channel"
require "feedjira/podcast/rss/required"

require "feedjira/podcast/xml/rss"
require "feedjira/podcast/xml/required"

require "feedjira/parser/podcast"

Feedjira::Feed.add_feed_class(Feedjira::Parser::Podcast)
