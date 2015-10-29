module Feedjira
  module Parser
    class PodcastItem
      include SAXMachine
      include FeedUtilities

      include ::Feedjira::Podcast::Item::Required
      include ::Feedjira::Podcast::Item::Optional
      include ::Feedjira::Podcast::Item::Apple
      include ::Feedjira::Podcast::Item::Dublin
      include ::Feedjira::Podcast::Item::Content
    end
  end
end
