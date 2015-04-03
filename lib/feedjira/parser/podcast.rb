module Feedjira
  module Parser
    class Podcast
      include SAXMachine
      include FeedUtilities

      include ::Feedjira::Podcast::Channel::Required
      include ::Feedjira::Podcast::Channel::Optional
      include ::Feedjira::Podcast::Channel::Atom
      include ::Feedjira::Podcast::Channel::Feedburner
      include ::Feedjira::Podcast::Channel::Apple

      elements :item, as: :items, class: PodcastItem

      def self.able_to_parse?(xml)
        # TODO Look for something podcast-specific
        (/\<rss|\<rdf/ =~ xml) && (/enclosure/ =~ xml)
      end
    end
  end
end