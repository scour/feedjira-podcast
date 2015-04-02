module Feedjira
  module Parser
    class Podcast
      include SAXMachine
      include FeedUtilities

      include ::Feedjira::Podcast::Channel::Required

      def self.able_to_parse?(xml)
        # TODO Look for something podcast-specific
        (/\<rss|\<rdf/ =~ xml) && (/enclosure/ =~ xml)
      end
    end
  end
end
