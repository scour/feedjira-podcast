module Feedjira
  module Podcast
    module RSS
      class Channel
        include SAXMachine
        include FeedUtilities

        include ::Feedjira::Podcast::Channel::Required
        include ::Feedjira::Podcast::Channel::Optional
        include ::Feedjira::Podcast::Channel::Atom
        include ::Feedjira::Podcast::Channel::Feedburner
        include ::Feedjira::Podcast::Channel::Apple

        elements :item, as: :items, class: ::Feedjira::Podcast::Channel::Item

        ancestor :rss
      end
    end
  end
end
