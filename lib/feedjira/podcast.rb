require 'feedjira'
require 'addressable/uri'

require 'feedjira/podcast/version'

require 'feedjira/podcast/channel/image'
require 'feedjira/podcast/channel/apple_owner'

require 'feedjira/podcast/channel/required'
require 'feedjira/podcast/channel/optional'
require 'feedjira/podcast/channel/atom'
require 'feedjira/podcast/channel/feedburner'
require 'feedjira/podcast/channel/apple'

require 'feedjira/podcast/item/guid'

require 'feedjira/podcast/item/required'
require 'feedjira/podcast/item/optional'
require 'feedjira/podcast/item/apple'
require 'feedjira/podcast/item/dublin'
require 'feedjira/podcast/item/content'

require 'feedjira/parser/podcast_item'
require 'feedjira/parser/podcast'

module Feedjira
  module Podcast
    # Your code goes here...
  end
end

Feedjira::Feed.add_feed_class(Feedjira::Parser::Podcast)
