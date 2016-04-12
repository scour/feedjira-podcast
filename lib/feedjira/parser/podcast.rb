module Feedjira
  module Parser
    class Podcast
      include SAXMachine
      include FeedUtilities

      include ::Feedjira::Podcast::XML::Required

      def self.able_to_parse?(xml)
        # TODO Look several something podcast-specific matches, especially
        # to cover feeds that may not have any items yet
        (/\<rss|\<rdf/ =~ xml) && (/enclosure/ =~ xml)
      end

      def method_missing(method_sym, *arguments, &block)
        if rss && rss.channel && rss.channel.respond_to?(method_sym)
          rss.channel.send(method_sym, *arguments, &block)
        else
          super
        end
      end

      def self.respond_to_missing?(method_sym, include_private = false)
        if rss && rss.channel && rss.channel.respond_to?(method_sym)
          true
        else
          super
        end
      end
    end
  end
end
