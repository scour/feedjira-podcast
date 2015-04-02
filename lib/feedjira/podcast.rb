require 'feedjira'
require 'addressable/uri'

require 'feedjira/podcast/version'

require 'feedjira/podcast/channel/required'
require 'feedjira/podcast/channel/optional'

require 'feedjira/parser/podcast'

module Feedjira
  module Podcast
    # Your code goes here...
  end
end

Feedjira::Feed.add_feed_class(Feedjira::Parser::Podcast)
